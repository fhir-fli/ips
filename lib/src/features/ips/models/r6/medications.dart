import 'package:fhir_r6/fhir_r6.dart';
import 'package:ips/src/features/ips/models/r6/bundle.dart';

extension MedicationRequestR6 on MedicationRequest {
  String getMedicationName() =>
      medication.concept?.text ??
      medication.concept?.coding?.first.display ??
      '--';

  String getMedicationForm(Bundle bundle) {
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medication.reference?.reference)
            as Medication?;
    if (medicationResource != null) {
      return medicationResource.doseForm?.text ??
          medicationResource.doseForm?.coding?.firstOrNull?.display ??
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

extension MedicationStatementR6 on MedicationStatement {
  String getMedicationName() =>
      medication.concept?.text ??
      medication.concept?.coding?.first.display ??
      '--';

  String getMedicationForm(Bundle bundle) {
    // Assuming MedicationStatement might have a reference to Medication similarly
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medication.reference?.reference)
            as Medication?;
    if (medicationResource != null) {
      return medicationResource.doseForm?.text ??
          medicationResource.doseForm?.coding?.firstOrNull?.display ??
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
