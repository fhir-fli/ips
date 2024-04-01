import 'package:fhir_r6/fhir_r6.dart';
import '../../ips.dart';

extension AllergyIntoleranceR6 on AllergyIntolerance {
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

  String display() {
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
