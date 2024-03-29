import 'package:fhir_r5/fhir_r5.dart';

extension AllergyIntoleranceR5 on AllergyIntolerance {
  String getAllergen() => code?.text ?? code?.coding?.first.display ?? '--';

  String getClinicalStatus() => clinicalStatus?.coding?.first.display ?? '--';

  String getVerificationStatus() =>
      verificationStatus?.coding?.first.display ?? '--';

  String getReaction() {
    if (reaction?.isNotEmpty ?? false) {
      return reaction!
          .map((r) => r.manifestation
              .map((m) => m.concept?.coding?.first.display ?? m.concept?.text)
              .join(', '))
          .join('; ');
    }
    return '--';
  }

  String getCriticality() => criticality?.value ?? '--';
}
