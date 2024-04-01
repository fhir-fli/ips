import 'package:fhir_r5/fhir_r5.dart';
import '../../ips.dart';

extension AllergyIntoleranceR5 on AllergyIntolerance {
  String getAllergen() =>
      code?.text ?? code?.coding?.first.display ?? ''.hardcoded;

  String getClinicalStatus() =>
      clinicalStatus?.coding?.first.display ?? ''.hardcoded;

  String getVerificationStatus() =>
      verificationStatus?.coding?.first.display ?? ''.hardcoded;

  String getReaction() {
    if (reaction?.isNotEmpty ?? false) {
      return reaction!
          .map((r) => r.manifestation
              .map((m) => m.concept?.coding?.first.display ?? m.concept?.text)
              .join(', '))
          .join('; ');
    }
    return ''.hardcoded;
  }

  String getCriticality() => criticality?.value ?? ''.hardcoded;

  String display(Bundle bundle) {
    List<String> parts = [
      getAllergen(),
      getClinicalStatus(),
      getVerificationStatus(),
      getReaction(),
      getCriticality(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
