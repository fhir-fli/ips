import 'package:fhir_r4/fhir_r4.dart';
import '../../ips.dart';

extension MedicationRequestR4 on MedicationRequest {
  String getMedicationName(Bundle bundle) {
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medicationReference?.reference)
            as Medication?;

    return medicationResource?.code?.coding?.firstOrNull?.display ??
        medicationCodeableConcept?.text ??
        medicationCodeableConcept?.coding?.first.display ??
        ''.hardcoded;
  }

  String getMedicationForm(Bundle bundle) {
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medicationReference?.reference)
            as Medication?;
    if (medicationResource != null) {
      return medicationResource.form?.text ??
          medicationResource.form?.coding?.firstOrNull?.display ??
          ''.hardcoded;
    }
    return ''.hardcoded;
  }

  String getRouteOfAdministration() =>
      dosageInstruction?.first.route?.coding?.first.display ??
      dosageInstruction?.first.route?.text ??
      ''.hardcoded;

  String getDosingTiming() =>
      dosageInstruction?.first.timing?.repeat?.frequency?.toString() ??
      dosageInstruction?.first.timing?.repeat?.period?.toString() ??
      ''.hardcoded;

  String getDoseQuantity() =>
      dosageInstruction?.first.doseAndRate?.first.doseQuantity?.value
          ?.toString() ??
      ''.hardcoded;

  String getInstructions() =>
      dosageInstruction?.first.patientInstruction ??
      dosageInstruction?.first.text ??
      ''.hardcoded;

  String display(Bundle bundle) {
    List<String> parts = [
      getMedicationName(bundle),
      getMedicationForm(bundle),
      getRouteOfAdministration(),
      getDosingTiming(),
      getDoseQuantity(),
      getInstructions(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}

extension MedicationStatementR4 on MedicationStatement {
  String getMedicationName(Bundle bundle) {
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medicationReference?.reference)
            as Medication?;

    return medicationResource?.code?.coding?.firstOrNull?.display ??
        medicationCodeableConcept?.text ??
        medicationCodeableConcept?.coding?.first.display ??
        ''.hardcoded;
  }

  String getMedicationForm(Bundle bundle) {
    // Assuming MedicationStatement might have a reference to Medication similarly
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medicationReference?.reference)
            as Medication?;
    if (medicationResource != null) {
      return medicationResource.form?.text ??
          medicationResource.form?.coding?.firstOrNull?.display ??
          ''.hardcoded;
    }
    return ''.hardcoded;
  }

  String getRouteOfAdministration() =>
      dosage?.first.route?.coding?.first.display ??
      dosage?.first.route?.text ??
      ''.hardcoded;

  String getDosingTiming() =>
      dosage?.first.timing?.repeat?.frequency?.toString() ??
      dosage?.first.timing?.repeat?.period?.toString() ??
      ''.hardcoded;

  String getDoseQuantity() =>
      dosage?.first.doseAndRate?.first.doseQuantity?.value?.toString() ??
      ''.hardcoded;

  String getInstructions() =>
      dosage?.first.patientInstruction ?? dosage?.first.text ?? ''.hardcoded;

  String display(Bundle bundle) {
    List<String> parts = [
      getMedicationName(bundle),
      getMedicationForm(bundle),
      getRouteOfAdministration(),
      getDosingTiming(),
      getDoseQuantity(),
      getInstructions(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
