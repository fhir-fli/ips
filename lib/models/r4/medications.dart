import 'package:fhir_r4/fhir_r4.dart';
import 'package:ips/models/r4/bundle.dart';

extension MedicationRequestR4 on MedicationRequest {
  String getMedicationName(Bundle bundle) {
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medicationReference?.reference)
            as Medication?;

    return medicationResource?.code?.coding?.firstOrNull?.display ??
        medicationCodeableConcept?.text ??
        medicationCodeableConcept?.coding?.first.display ??
        '--';
  }

  String getMedicationForm(Bundle bundle) {
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medicationReference?.reference)
            as Medication?;
    if (medicationResource != null) {
      return medicationResource.form?.text ??
          medicationResource.form?.coding?.firstOrNull?.display ??
          '--';
    }
    return '--';
  }

  String getRouteOfAdministration() =>
      dosageInstruction?.first.route?.coding?.first.display ??
      dosageInstruction?.first.route?.text ??
      '--';

  String getDosingTiming() =>
      dosageInstruction?.first.timing?.repeat?.frequency?.toString() ??
      dosageInstruction?.first.timing?.repeat?.period?.toString() ??
      '--';

  String getDoseQuantity() =>
      dosageInstruction?.first.doseAndRate?.first.doseQuantity?.value
          ?.toString() ??
      '--';

  String getInstructions() =>
      dosageInstruction?.first.patientInstruction ??
      dosageInstruction?.first.text ??
      '--';
}

extension MedicationStatementR4 on MedicationStatement {
  String getMedicationName(Bundle bundle) {
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medicationReference?.reference)
            as Medication?;

    return medicationResource?.code?.coding?.firstOrNull?.display ??
        medicationCodeableConcept?.text ??
        medicationCodeableConcept?.coding?.first.display ??
        '--';
  }

  String getMedicationForm(Bundle bundle) {
    // Assuming MedicationStatement might have a reference to Medication similarly
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medicationReference?.reference)
            as Medication?;
    if (medicationResource != null) {
      return medicationResource.form?.text ??
          medicationResource.form?.coding?.firstOrNull?.display ??
          '--';
    }
    return '--';
  }

  String getRouteOfAdministration() =>
      dosage?.first.route?.coding?.first.display ??
      dosage?.first.route?.text ??
      '--';

  String getDosingTiming() =>
      dosage?.first.timing?.repeat?.frequency?.toString() ??
      dosage?.first.timing?.repeat?.period?.toString() ??
      '--';

  String getDoseQuantity() =>
      dosage?.first.doseAndRate?.first.doseQuantity?.value?.toString() ?? '--';

  String getInstructions() =>
      dosage?.first.patientInstruction ?? dosage?.first.text ?? '--';
}
