import 'package:fhir_r4/fhir_r4.dart';

extension AllergyIntoleranceR4 on AllergyIntolerance {
  String getAllergen() => code?.text ?? code?.coding?.first.display ?? '--';

  String getClinicalStatus() => clinicalStatus?.coding?.first.display ?? '--';

  String getVerificationStatus() =>
      verificationStatus?.coding?.first.display ?? '--';

  String getReaction() {
    if (reaction?.isNotEmpty ?? false) {
      return reaction!
          .map((r) => r.manifestation
              .map((m) => m.coding?.first.display ?? m.text)
              .join(', '))
          .join('; ');
    }
    return '--';
  }

  String getCriticality() => criticality?.value ?? '--';
}
