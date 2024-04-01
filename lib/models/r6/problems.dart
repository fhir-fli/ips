import 'package:fhir_r6/fhir_r6.dart';
import '../../ips.dart';

extension ConditionR6 on Condition {
  String getConditionName() =>
      code?.text ?? code?.coding?.first.display ?? ''.hardcoded;

  String getClinicalStatus() =>
      clinicalStatus.coding?.first.display ?? ''.hardcoded;

  String getVerificationStatus() =>
      verificationStatus?.coding?.first.display ?? ''.hardcoded;

  String getSeverity() => severity?.coding?.first.display ?? ''.hardcoded;

  String getOnsetDateTime() {
    if (onsetDateTime != null) {
      return onsetDateTime!.toIso8601String();
    } else if (onsetPeriod != null) {
      final start = onsetPeriod!.start?.toIso8601String() ?? ''.hardcoded;
      final end = onsetPeriod!.end?.toIso8601String() ?? ''.hardcoded;
      return '$start to $end';
    } else if (onsetAge != null) {
      return 'Age at onset: ${onsetAge!.value?.toString()} ${onsetAge!.unit}';
    } else if (onsetRange != null) {
      final low = onsetRange!.low?.value?.toString() ?? ''.hardcoded;
      final high = onsetRange!.high?.value?.toString() ?? ''.hardcoded;
      return 'Range: $low to $high';
    } else if (onsetString != null) {
      return onsetString!;
    }
    return ''.hardcoded;
  }

  String getNotes() =>
      note?.map((n) => n.text ?? ''.hardcoded).join('; ') ?? ''.hardcoded;

  String getResolutionDateTime() {
    if (abatementDateTime != null) {
      return abatementDateTime!.toIso8601String();
    } else if (abatementPeriod != null) {
      return abatementPeriod!.start?.toIso8601String() ?? ''.hardcoded;
    }
    return ''.hardcoded;
  }

  String display() {
    List<String> parts = [
      getConditionName(),
      getClinicalStatus(),
      getVerificationStatus(),
      getSeverity(),
      getOnsetDateTime(),
      getResolutionDateTime(),
      getNotes(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
