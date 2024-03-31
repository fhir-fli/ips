import 'package:fhir_r6/fhir_r6.dart';

extension AllergyIntoleranceR6 on AllergyIntolerance {
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
