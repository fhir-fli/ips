import 'package:fhir_r5/fhir_r5.dart';
import 'package:ips/src/features/ips/models/r5/bundle.dart';

extension MedicationRequestR5 on MedicationRequest {
  String getMedicationName(Bundle bundle) {
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medication.reference?.reference)
            as Medication?;

    return medicationResource?.code?.coding?.firstOrNull?.display ??
        medication.concept?.text ??
        medication.concept?.coding?.first.display ??
        '--';
  }

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

extension MedicationStatementR5 on MedicationStatement {
  String getMedicationName(Bundle bundle) {
    final Medication? medicationResource =
        bundle.resourceFromBundleByReference(medication.reference?.reference)
            as Medication?;

    return medicationResource?.code?.coding?.firstOrNull?.display ??
        medication.concept?.text ??
        medication.concept?.coding?.first.display ??
        '--';
  }

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
