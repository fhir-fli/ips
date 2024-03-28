import 'package:collection/collection.dart';
import 'package:fhir_r5/fhir_r5.dart';

import '../../../../src.dart';

AllergyDisplay allergyDisplayFromAllergyIntoleranceR5(
    AllergyIntolerance allergy) {
  return AllergyDisplay(
    allergen: allergy.code?.text ?? allergy.code?.coding?.firstOrNull?.display,
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

FunctionalStatusDisplay functionalStatusDisplayFromConditionR5(
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

FunctionalStatusDisplay functionalStatusDisplayFromClinicalImpressionR5(
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

ImmunizationDisplay immunizationDisplayFromImmunizationR5(
    Immunization immunization) {
  return ImmunizationDisplay(
    vaccineName: immunization.vaccineCode.text ??
        immunization.vaccineCode.coding?.firstOrNull?.display,
    vaccinationDate: immunization.occurrenceDateTime?.value,
    status: immunization.status?.value,
  );
}

MedicationDeviceDisplay medicationDeviceDisplayFromDeviceUseStatementR5(
    DeviceUsage deviceUseStatement, Bundle bundle) {
  // Assuming the device reference is correctly formatted and exists within the same bundle
  String deviceReference = deviceUseStatement.device.reference?.reference ?? '';
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

MedicationDisplay medicationDisplayFromMedicationStatementR5(
    MedicationStatement medicationStatement, Bundle bundle) {
  return populateMedicationDisplayR5(
    medicationReference: medicationStatement.medication.reference,
    medicationCodeableConcept: medicationStatement.medication.concept,
    dosages: medicationStatement.dosage,
    bundle: bundle,
  );
}

MedicationDisplay medicationDisplayFromMedicationRequestR5(
    MedicationRequest medicationRequest, Bundle bundle) {
  return populateMedicationDisplayR5(
    medicationReference: medicationRequest.medication.reference,
    medicationCodeableConcept: medicationRequest.medication.concept,
    dosages: medicationRequest.dosageInstruction,
    bundle: bundle,
  );
}

MedicationDisplay populateMedicationDisplayR5({
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
          'Medication/${entry.resource?.id}' == medicationReference?.reference)
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

PastIllnessHistoryDisplay pastIllnessHistoryDisplayFromConditionR5(
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

PlanOfCareDisplay planOfCareDisplayFromCarePlanR5(CarePlan carePlan) {
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

ProblemDisplay problemDisplayFromConditionR5(Condition condition) {
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

ResultDisplay resultsDisplayFromObservationR5(Observation observation) {
  return ResultDisplay(
    resultType:
        observation.code.text ?? observation.code.coding?.firstOrNull?.display,
    resultValue:
        observation.valueQuantity?.value?.toString() ?? observation.valueString,
    resultInterpretation:
        observation.interpretation?.firstOrNull?.coding?.firstOrNull?.display,
    observationMethod: observation.method?.text ??
        observation.method?.coding?.firstOrNull?.display,
    effectiveDateTime: observation.effectiveDateTime?.value,
    notes: observation.note?.map((e) => e.text).join(' '),
  );
}

ResultDisplay resultsDisplayFromDiagnosticReportR5(
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

SocialHistoryDisplay socialHistoryDisplayFromObservationR5(
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

VitalSignDisplay vitalSignDisplayFromObservationR5(Observation observation) {
  String? observationValue;
  if (observation.valueQuantity != null) {
    observationValue =
        '${observation.valueQuantity?.value} ${observation.valueQuantity?.unit}';
  } else if (observation.valueCodeableConcept != null) {
    observationValue = observation.valueCodeableConcept?.text ??
        observation.valueCodeableConcept?.coding?.firstOrNull?.display;
  }

  return VitalSignDisplay(
    vitalSignType:
        observation.code.text ?? observation.code.coding?.firstOrNull?.display,
    value: observationValue,
    observationDate: observation.effectiveDateTime?.value,
    unit: observation.valueQuantity?.unit,
  );
}
