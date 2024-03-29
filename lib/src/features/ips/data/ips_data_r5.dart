import 'package:collection/collection.dart';
import 'package:fhir_primitives/fhir_primitives.dart';
import 'package:fhir_r5/fhir_r5.dart';

import '../../../../ips.dart';

class IpsDataR5 {
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

  IpsDataR5(this.bundle) {
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
        bundle.resourceFromBundle(composition?.subject?.firstOrNull?.reference)
            as Patient?;
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
              .map((m) =>
                  m.concept?.coding?.firstOrNull?.display ?? m.concept?.text)
              .join(', '))
          .join('; '),
      criticality: allergy.criticality?.value,
    );
  }

  FunctionalStatusDisplay functionalStatusDisplayFromCondition(
      Condition condition) {
    return FunctionalStatusDisplay(
      status: condition.clinicalStatus.coding?.firstOrNull?.display,
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
              f.item?.concept?.text ??
              f.item?.concept?.coding?.firstOrNull?.display)
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
      DeviceUsage deviceUseStatement, Bundle bundle) {
    // Assuming the device reference is correctly formatted and exists within the same bundle
    String deviceReference =
        deviceUseStatement.device.reference?.reference ?? '';
    Device? device = bundle.resourceFromBundle(deviceReference) as Device?;

    // Constructing the reason from the reasonCode field
    String? reasons = deviceUseStatement.reason?.firstOrNull?.concept?.coding
        ?.map((coding) => coding.code?.value ?? coding.display)
        .join(", ");

    return MedicationDeviceDisplay(
      deviceName: device?.type?.firstOrNull?.text ??
          device?.type?.firstOrNull?.coding?.firstOrNull?.display,
      status: deviceUseStatement.status?.value,
      timing: deviceUseStatement.timingDateTime?.value ??
          deviceUseStatement.timingPeriod?.start?.value,
      reason: reasons,
    );
  }

  MedicationDisplay medicationDisplayFromMedicationStatement(
      MedicationStatement medicationStatement, Bundle bundle) {
    return populateMedicationDisplay(
      medicationReference: medicationStatement.medication.reference,
      medicationCodeableConcept: medicationStatement.medication.concept,
      dosages: medicationStatement.dosage,
      bundle: bundle,
    );
  }

  MedicationDisplay medicationDisplayFromMedicationRequest(
      MedicationRequest medicationRequest, Bundle bundle) {
    return populateMedicationDisplay(
      medicationReference: medicationRequest.medication.reference,
      medicationCodeableConcept: medicationRequest.medication.concept,
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
      display.medicationForm = medicationResource.doseForm?.text ??
          medicationResource.doseForm?.coding?.firstOrNull?.display;
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
      clinicalStatus: condition.clinicalStatus.coding?.firstOrNull?.display,
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
      ..clinicalStatus = condition.clinicalStatus.coding?.firstOrNull?.display
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
      performedDateTime: procedure.occurrenceDateTime?.value,
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
}
