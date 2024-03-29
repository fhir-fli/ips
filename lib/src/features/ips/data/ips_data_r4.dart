import 'package:collection/collection.dart';
import 'package:fhir_primitives/fhir_primitives.dart';
import 'package:fhir_r4/fhir_r4.dart';

import '../../../../ips.dart';

class IpsDataR4 {
  final Bundle bundle;
  Composition? composition;
  Patient? patient;
  final Map<IpsSections, List<String>> sectionReferences = {};
  final Map<String, IpsSections> loincToSection = {
    '10160-0': IpsSections.medications,
    '48765-2': IpsSections.allergies,
    '11450-4': IpsSections.problems,
    '47519-4': IpsSections.procedures,
    '11369-6': IpsSections.immunizations,
    '46264-8': IpsSections.medicationDevices,
    '30954-2': IpsSections.results,
    '8716-3': IpsSections.vitalSigns,
    '11348-0': IpsSections.pastIllnessHx,
    '47420-5': IpsSections.functionalStatus,
    '18776-5': IpsSections.planOfCare,
    '29762-2': IpsSections.socialHistory,
    '10162-6': IpsSections.pregnancyHx,
    '42348-3': IpsSections.advanceDirectives,
  };

  IpsDataR4(this.bundle) {
    _parseComposition();
    _parseSectionReferences();
    _parsePatient();
  }

  void _parseComposition() {
    composition = bundle.entry
        ?.map((entry) => entry.resource)
        .whereType<Composition>()
        .firstWhereOrNull((composition) =>
            composition.type.coding?.any((coding) =>
                coding.system == FhirUri('http://loinc.org') &&
                coding.code == FhirCode('60591-5')) ??
            false);
  }

  void _parseSectionReferences() {
    composition?.section?.forEach((section) {
      final coding = section.code?.coding?.firstWhereOrNull(
          (Coding coding) => loincToSection.containsKey(coding.code?.value));
      if (coding != null) {
        final sectionType = loincToSection[coding.code!.value!];
        if (sectionType != null) {
          final stringList = <String>[];
          section.entry?.forEach((entry) {
            if (entry.reference != null) {
              stringList.add(entry.reference!);
            }
          });
          sectionReferences[sectionType] = stringList;
        }
      }
    });
  }

  void _parsePatient() {
    patient =
        bundle.resourceFromBundle(composition?.subject?.reference) as Patient?;
  }

  // Medications getter
  List<MedicationDisplay> get medications {
    final medicationDisplays = <MedicationDisplay>[];
    for (final entry
        in sectionReferences[IpsSections.medications] ?? <String>[]) {
      final resource = bundle.resourceFromBundle(entry);
      if (resource != null) {
        if (resource is MedicationRequest) {
          medicationDisplays
              .add(medicationDisplayFromMedicationRequest(resource, bundle));
        } else if (resource is MedicationStatement) {
          medicationDisplays
              .add(medicationDisplayFromMedicationStatement(resource, bundle));
        }
      }
    }
    return medicationDisplays;
  }

  List<AllergyDisplay> get allergies =>
      (sectionReferences[IpsSections.allergies] ?? [])
          .map((ref) => bundle.resourceFromBundle(ref))
          .whereType<AllergyIntolerance>()
          .map(allergyDisplayFromAllergyIntolerance)
          .toList();

  List<ProblemDisplay> get problems =>
      (sectionReferences[IpsSections.problems] ?? [])
          .map((ref) => bundle.resourceFromBundle(ref))
          .whereType<Condition>()
          .map(problemDisplayFromCondition)
          .toList();

  List<ProcedureDisplay> get procedures =>
      (sectionReferences[IpsSections.procedures] ?? [])
          .map((ref) => bundle.resourceFromBundle(ref))
          .whereType<Procedure>()
          .map(procedureDisplayFromProcedure)
          .toList();

  List<ImmunizationDisplay> get immunizations =>
      (sectionReferences[IpsSections.immunizations] ?? [])
          .map((ref) => bundle.resourceFromBundle(ref))
          .whereType<Immunization>()
          .map(immunizationDisplayFromImmunization)
          .toList();

  List<MedicationDeviceDisplay> get medicationDevices =>
      (sectionReferences[IpsSections.medicationDevices] ?? [])
          .map((ref) => bundle.resourceFromBundle(ref))
          .whereType<DeviceUseStatement>()
          .map((deviceUseStatement) =>
              medicationDeviceDisplayFromDeviceUseStatement(
                  deviceUseStatement, bundle))
          .toList();

  List<ResultDisplay> get results =>
      (sectionReferences[IpsSections.results] ?? [])
          .map((ref) => bundle.resourceFromBundle(ref))
          .map((resource) => resource is Observation
              ? resultsDisplayFromObservation(resource)
              : resource is DiagnosticReport
                  ? resultsDisplayFromDiagnosticReport(resource, bundle)
                  : null)
          .whereType<ResultDisplay>()
          .toList();

  List<VitalSignDisplay> get vitalSigns =>
      (sectionReferences[IpsSections.vitalSigns] ?? [])
          .map((ref) => bundle.resourceFromBundle(ref))
          .whereType<Observation>()
          .map(vitalSignDisplayFromObservation)
          .toList();

  List<PastIllnessHistoryDisplay> get pastIllnessHx =>
      (sectionReferences[IpsSections.pastIllnessHx] ?? [])
          .map((ref) => bundle.resourceFromBundle(ref))
          .whereType<Condition>()
          .map(pastIllnessHistoryDisplayFromCondition)
          .toList();

  List<FunctionalStatusDisplay> get functionalStatus {
    final functionalStatusDisplays = <FunctionalStatusDisplay>[];
    final conditionRefs =
        sectionReferences[IpsSections.functionalStatus]?.whereType<String>() ??
            [];
    final conditionResources = conditionRefs
        .map((ref) => bundle.resourceFromBundle(ref))
        .whereType<Condition>();
    functionalStatusDisplays
        .addAll(conditionResources.map(functionalStatusDisplayFromCondition));

    final clinicalImpressionRefs =
        sectionReferences[IpsSections.functionalStatus]?.whereType<String>() ??
            [];
    final clinicalImpressionResources = clinicalImpressionRefs
        .map((ref) => bundle.resourceFromBundle(ref))
        .whereType<ClinicalImpression>();
    functionalStatusDisplays.addAll(clinicalImpressionResources.map(
        (ci) => functionalStatusDisplayFromClinicalImpression(ci, bundle)));

    return functionalStatusDisplays;
  }

  List<PlanOfCareDisplay> get planOfCare =>
      (sectionReferences[IpsSections.planOfCare] ?? [])
          .map((ref) => bundle.resourceFromBundle(ref))
          .whereType<CarePlan>()
          .map(planOfCareDisplayFromCarePlan)
          .toList();

  List<SocialHistoryDisplay> get socialHistory =>
      (sectionReferences[IpsSections.socialHistory] ?? [])
          .map((ref) => bundle.resourceFromBundle(ref))
          .whereType<Observation>()
          .map(socialHistoryDisplayFromObservation)
          .toList();

  List<PregnancyDisplay> get pregnancyHx {
    return (sectionReferences[IpsSections.pregnancyHx] ?? <String>[])
        .map((ref) => bundle.resourceFromBundle(ref))
        .whereType<Observation>()
        .map(pregnancyDisplayFromObservation)
        .toList();
  }

  List<AdvanceDirectiveDisplay> get advanceDirectives {
    return (sectionReferences[IpsSections.advanceDirectives] ?? <String>[])
        .map((ref) => bundle.resourceFromBundle(ref))
        .whereType<
            DocumentReference>() // Assuming advance directives are represented as DocumentReferences
        .map(
            advanceDirectiveDisplayFromDocumentReference) // Assuming you have a function to transform a DocumentReference to AdvanceDirectiveDisplay
        .toList();
  }

  AllergyDisplay allergyDisplayFromAllergyIntolerance(
      AllergyIntolerance allergy) {
    return AllergyDisplay(
      allergen:
          allergy.code?.text ?? allergy.code?.coding?.firstOrNull?.display,
      clinicalStatus: allergy.clinicalStatus?.coding?.firstOrNull?.display,
      verificationStatus:
          allergy.verificationStatus?.coding?.firstOrNull?.display,
      reaction: allergy.reaction
          ?.map((r) => r.manifestation
              .map((m) => m.coding?.firstOrNull?.display ?? m.text)
              .join(', '))
          .join('; '),
      criticality: allergy.criticality?.value,
    );
  }

  FunctionalStatusDisplay functionalStatusDisplayFromCondition(
      Condition condition) {
    return FunctionalStatusDisplay(
      status: condition.clinicalStatus?.coding?.firstOrNull?.display,
      severity: condition.severity?.coding?.firstOrNull?.display,
      codeDisplay:
          condition.code?.text ?? condition.code?.coding?.firstOrNull?.display,
      bodySite: condition.bodySite?.firstOrNull?.text ??
          condition.bodySite?.firstOrNull?.coding?.firstOrNull?.display,
      onsetDateTime: condition.onsetDateTime?.value,
      notes: condition.note?.map((e) => e.text).join(' '),
    );
  }

  FunctionalStatusDisplay functionalStatusDisplayFromClinicalImpression(
      ClinicalImpression clinicalImpression, Bundle bundle) {
    String? findings;
    // Potentially, clinicalImpression.finding could contain relevant information
    if (clinicalImpression.finding?.isNotEmpty ?? false) {
      findings = clinicalImpression.finding!
          .map((f) =>
              f.itemCodeableConcept?.text ??
              f.itemCodeableConcept?.coding?.firstOrNull?.display)
          .join(', ');
    }

    return FunctionalStatusDisplay(
      status: clinicalImpression.status?.value,
      // Severity might not directly map, but interpretation or findings might give clues
      codeDisplay: findings,
      onsetDateTime: clinicalImpression.date?.value,
      notes: clinicalImpression.summary,
    );
  }

  ImmunizationDisplay immunizationDisplayFromImmunization(
      Immunization immunization) {
    return ImmunizationDisplay(
      vaccineName: immunization.vaccineCode.text ??
          immunization.vaccineCode.coding?.firstOrNull?.display,
      vaccinationDate: immunization.occurrenceDateTime?.value,
      status: immunization.status?.value,
    );
  }

  MedicationDeviceDisplay medicationDeviceDisplayFromDeviceUseStatement(
      DeviceUseStatement deviceUseStatement, Bundle bundle) {
    // Assuming the device reference is correctly formatted and exists within the same bundle
    String deviceReference = deviceUseStatement.device.reference ?? '';
    Device? device = bundle.resourceFromBundle(deviceReference) as Device?;

    // Constructing the reason from the reasonCode field
    String? reasons = deviceUseStatement.reasonCode
        ?.map((code) => code.text ?? code.coding?.firstOrNull?.display)
        .join(", ");

    return MedicationDeviceDisplay(
      deviceName:
          device?.type?.text ?? device?.type?.coding?.firstOrNull?.display,
      status: deviceUseStatement.status?.value,
      timing: deviceUseStatement.timingDateTime?.value ??
          deviceUseStatement.timingPeriod?.start?.value,
      reason: reasons,
    );
  }

  MedicationDisplay medicationDisplayFromMedicationStatement(
      MedicationStatement medicationStatement, Bundle bundle) {
    return populateMedicationDisplay(
      medicationReference: medicationStatement.medicationReference,
      medicationCodeableConcept: medicationStatement.medicationCodeableConcept,
      dosages: medicationStatement.dosage,
      bundle: bundle,
    );
  }

  MedicationDisplay medicationDisplayFromMedicationRequest(
      MedicationRequest medicationRequest, Bundle bundle) {
    return populateMedicationDisplay(
      medicationReference: medicationRequest.medicationReference,
      medicationCodeableConcept: medicationRequest.medicationCodeableConcept,
      dosages: medicationRequest.dosageInstruction,
      bundle: bundle,
    );
  }

  MedicationDisplay populateMedicationDisplay({
    Reference? medicationReference,
    CodeableConcept? medicationCodeableConcept,
    List<Dosage>? dosages,
    required Bundle bundle,
  }) {
    MedicationDisplay display = MedicationDisplay();

    // Extract medication info
    final medicationResource = bundle.entry
        ?.firstWhereOrNull((entry) =>
            entry.fullUrl == medicationReference?.reference ||
            'Medication/${entry.resource?.id}' ==
                medicationReference?.reference)
        ?.resource;

    if (medicationResource is Medication) {
      display.medicationName = medicationResource.code?.text ??
          medicationResource.code?.coding?.firstOrNull?.display;
      display.medicationForm = medicationResource.form?.text ??
          medicationResource.form?.coding?.firstOrNull?.display;
    } else if (medicationCodeableConcept != null) {
      display.medicationName = medicationCodeableConcept.text ??
          medicationCodeableConcept.coding?.firstOrNull?.display;
    }

    // Extract dosing info
    if (dosages?.isNotEmpty == true) {
      final dosage = dosages!.first;
      display.routeOfAdministration =
          dosage.route?.text ?? dosage.route?.coding?.firstOrNull?.display;
      display.dosingTiming = dosage.timing?.repeat?.frequency?.toString() ??
          dosage.timing?.repeat?.boundsPeriod?.start?.value.toIso8601String();
      display.doseQuantity =
          dosage.doseAndRate?.firstOrNull?.doseQuantity?.value?.toString();
      display.instructions = dosage.patientInstruction ?? dosage.text;
    }

    return display;
  }

  PastIllnessHistoryDisplay pastIllnessHistoryDisplayFromCondition(
      Condition condition) {
    return PastIllnessHistoryDisplay(
      conditionName:
          condition.code?.text ?? condition.code?.coding?.firstOrNull?.display,
      clinicalStatus: condition.clinicalStatus?.coding?.firstOrNull?.display,
      verificationStatus:
          condition.verificationStatus?.coding?.firstOrNull?.display,
      severity: condition.severity?.coding?.firstOrNull?.display,
      onsetDateTime: condition.onsetDateTime?.value,
      resolutionDateTime: condition.abatementDateTime?.value.toIso8601String(),
      notes: condition.note?.map((e) => e.text).join(' '),
    );
  }

  PlanOfCareDisplay planOfCareDisplayFromCarePlan(CarePlan carePlan) {
    final category = carePlan.category?.firstOrNull?.text ??
        carePlan.category?.firstOrNull?.coding?.firstOrNull?.display;
    final summary = carePlan.description;

    // Start and end date might be derived from the period
    final startDate = carePlan.period?.start?.value;
    final endDate = carePlan.period?.end?.value;

    return PlanOfCareDisplay(
      category: category,
      summary: summary,
      status: carePlan.status?.value,
      startDate: startDate,
      endDate: endDate,
      intent: carePlan.intent?.value,
    );
  }

  ProblemDisplay problemDisplayFromCondition(Condition condition) {
    return ProblemDisplay()
      ..conditionName =
          condition.code?.text ?? condition.code?.coding?.firstOrNull?.display
      ..clinicalStatus = condition.clinicalStatus?.coding?.firstOrNull?.display
      ..verificationStatus =
          condition.verificationStatus?.coding?.firstOrNull?.display
      ..severity = condition.severity?.coding?.firstOrNull?.display
      ..onsetDateTime = _parseOnset(condition)
      ..notes = condition.note?.map((e) => e.text).join(' ');
  }

  String? _parseOnset(Condition condition) {
    if (condition.onsetDateTime != null) {
      return condition.onsetDateTime!.toIso8601String();
    } else if (condition.onsetPeriod != null) {
      return '${condition.onsetPeriod!.start?.toIso8601String()} to ${condition.onsetPeriod!.end?.toIso8601String()}';
    } else if (condition.onsetAge != null) {
      return 'Age at onset: ${condition.onsetAge!.value?.toString()} ${condition.onsetAge!.unit}';
    } else if (condition.onsetRange != null) {
      return 'Range: ${condition.onsetRange!.low?.value?.toString()} to ${condition.onsetRange!.high?.value?.toString()}';
    } else if (condition.onsetString != null) {
      return condition.onsetString;
    }
    return null;
  }

  ProcedureDisplay procedureDisplayFromProcedure(Procedure procedure) {
    return ProcedureDisplay(
      procedureName:
          procedure.code?.text ?? procedure.code?.coding?.firstOrNull?.display,
      status: procedure.status?.value,
      performedDateTime: procedure.performedDateTime?.value,
      performer: procedure.performer?.firstOrNull?.actor.display,
      location: procedure.location?.display,
    );
  }

  ResultDisplay resultsDisplayFromObservation(Observation observation) {
    return ResultDisplay(
      resultType: observation.code.text ??
          observation.code.coding?.firstOrNull?.display,
      resultValue: observation.valueQuantity?.value?.toString() ??
          observation.valueString,
      resultInterpretation:
          observation.interpretation?.firstOrNull?.coding?.firstOrNull?.display,
      observationMethod: observation.method?.text ??
          observation.method?.coding?.firstOrNull?.display,
      effectiveDateTime: observation.effectiveDateTime?.value,
      notes: observation.note?.map((e) => e.text).join(' '),
    );
  }

  ResultDisplay resultsDisplayFromDiagnosticReport(
      DiagnosticReport diagnosticReport, Bundle bundle) {
    // Initialize default values
    String? primaryResultValue;
    DateTime? effectiveDateTime;
    String? notes;

    // Attempt to extract more detailed information from the first result, if available
    if (diagnosticReport.result?.isNotEmpty == true) {
      final Observation? primaryObservation =
          bundle.resourceFromBundle(diagnosticReport.result!.first.reference)
              as Observation?;

      if (primaryObservation != null) {
        primaryResultValue =
            primaryObservation.valueQuantity?.value?.toString() ??
                primaryObservation.valueString;
        effectiveDateTime = primaryObservation.effectiveDateTime?.value;
        notes = primaryObservation.note?.map((e) => e.text).join(' ');
      }
    }

    return ResultDisplay(
      resultType: diagnosticReport.code.text ??
          diagnosticReport.code.coding?.firstOrNull?.display,
      resultValue: primaryResultValue,
      effectiveDateTime: effectiveDateTime,
      notes: notes,
    );
  }

  SocialHistoryDisplay socialHistoryDisplayFromObservation(
      Observation observation) {
    final socialFactor =
        observation.code.text ?? observation.code.coding?.firstOrNull?.display;
    String? value;
    if (observation.valueQuantity != null) {
      value =
          '${observation.valueQuantity?.value} ${observation.valueQuantity?.unit}';
    } else if (observation.valueCodeableConcept != null) {
      value = observation.valueCodeableConcept?.text ??
          observation.valueCodeableConcept?.coding?.firstOrNull?.display;
    } else if (observation.valueString != null) {
      value = observation.valueString;
    }

    return SocialHistoryDisplay(
      socialFactor: socialFactor,
      value: value,
      observationDate: observation.effectiveDateTime?.value,
      notes: observation.note?.map((e) => e.text).join(' '),
    );
  }

  VitalSignDisplay vitalSignDisplayFromObservation(Observation observation) {
    String? observationValue;
    if (observation.valueQuantity != null) {
      observationValue =
          '${observation.valueQuantity?.value} ${observation.valueQuantity?.unit}';
    } else if (observation.valueCodeableConcept != null) {
      observationValue = observation.valueCodeableConcept?.text ??
          observation.valueCodeableConcept?.coding?.firstOrNull?.display;
    }

    return VitalSignDisplay(
      vitalSignType: observation.code.text ??
          observation.code.coding?.firstOrNull?.display,
      value: observationValue,
      observationDate: observation.effectiveDateTime?.value,
      unit: observation.valueQuantity?.unit,
    );
  }

  PregnancyDisplay pregnancyDisplayFromObservation(Observation observation) {
    final observationType =
        observation.code.text ?? observation.code.coding?.firstOrNull?.display;
    String? value;
    if (observation.valueQuantity != null) {
      value =
          '${observation.valueQuantity?.value} ${observation.valueQuantity?.unit}';
    } else if (observation.valueCodeableConcept != null) {
      value = observation.valueCodeableConcept?.text ??
          observation.valueCodeableConcept?.coding?.firstOrNull?.display;
    } else if (observation.valueString != null) {
      value = observation.valueString;
    }

    return PregnancyDisplay(
      observationType: observationType,
      value: value,
      observationDate: observation.effectiveDateTime?.value,
      notes: observation.note?.map((e) => e.text).join(' '),
    );
  }
}
