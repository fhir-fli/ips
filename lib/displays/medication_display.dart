import 'package:fhir_r4/fhir_r4.dart';
import 'package:collection/collection.dart';

class MedicationDisplay {
  String? medicationName;
  String? medicationForm;
  String? routeOfAdministration;
  String? dosingTiming;
  String? doseQuantity;
  String? instructions;

  MedicationDisplay({
    this.medicationName,
    this.medicationForm,
    this.routeOfAdministration,
    this.dosingTiming,
    this.doseQuantity,
    this.instructions,
  });

  factory MedicationDisplay.fromMedicationStatement(
      MedicationStatement medicationStatement, Bundle bundle) {
    return MedicationDisplay()._populateMedicationDisplay(
        medicationStatement.medicationReference,
        medicationStatement.medicationCodeableConcept,
        medicationStatement.dosage,
        bundle);
  }

  factory MedicationDisplay.fromMedicationRequest(
      MedicationRequest medicationRequest, Bundle bundle) {
    return MedicationDisplay()._populateMedicationDisplay(
        medicationRequest.medicationReference,
        medicationRequest.medicationCodeableConcept,
        medicationRequest.dosageInstruction,
        bundle);
  }

  // Additional constructors for MedicationDispense and MedicationAdministration can be added here.

  MedicationDisplay _populateMedicationDisplay(
      Reference? medicationReference,
      CodeableConcept? medicationCodeableConcept,
      List<Dosage>? dosages,
      Bundle bundle) {
    _extractMedicationInfo(
        medicationReference, medicationCodeableConcept, bundle);
    _extractDosingInfo(dosages);
    return this;
  }

  void _extractMedicationInfo(
      Reference? reference, CodeableConcept? codeableConcept, Bundle bundle) {
    final medicationResource = bundle.entry
        ?.firstWhereOrNull((entry) =>
            entry.fullUrl == reference?.reference ||
            'Medication/${entry.resource?.id}' == reference?.reference)
        ?.resource;

    if (medicationResource is Medication) {
      medicationName = medicationResource.code?.text ??
          medicationResource.code?.coding?.firstOrNull?.display;
      medicationForm = medicationResource.form?.text ??
          medicationResource.form?.coding?.firstOrNull?.display;
    } else if (codeableConcept != null) {
      medicationName =
          codeableConcept.text ?? codeableConcept.coding?.firstOrNull?.display;
    }
  }

  void _extractDosingInfo(List<Dosage>? dosages) {
    if (dosages?.isNotEmpty == true) {
      final dosage = dosages!.first;
      routeOfAdministration =
          dosage.route?.text ?? dosage.route?.coding?.firstOrNull?.display;
      dosingTiming = dosage.timing?.repeat?.frequency?.toString() ??
          dosage.timing?.repeat?.boundsPeriod?.start?.value.toIso8601String();
      doseQuantity =
          dosage.doseAndRate?.firstOrNull?.doseQuantity?.value?.toString();
      instructions = dosage.patientInstruction ?? dosage.text;
    }
  }

  @override
  String toString() {
    final parts = [
      if (medicationName != null) 'Medication: $medicationName',
      if (medicationForm != null) 'Form: $medicationForm',
      if (routeOfAdministration != null) 'Route: $routeOfAdministration',
      if (dosingTiming != null) 'Timing: $dosingTiming',
      if (doseQuantity != null) 'Dose: $doseQuantity',
      if (instructions != null) 'Instructions: $instructions',
    ];
    return parts.join(', ');
  }
}
