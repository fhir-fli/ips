import 'package:fhir_r5/fhir_r5.dart';
import '../../ips.dart';

extension ConditionPastIllnessR5 on Condition {
  String getConditionName() =>
      code?.text ?? code?.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getClinicalStatus() =>
      clinicalStatus.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getVerificationStatus() =>
      verificationStatus?.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getSeverity() =>
      severity?.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getOnsetDateTime() {
    if (onsetDateTime != null) {
      return onsetDateTime!.toIso8601String();
    } else if (onsetPeriod != null) {
      return '${onsetPeriod!.start?.toIso8601String()} to ${onsetPeriod!.end?.toIso8601String()}';
    } else if (onsetAge != null) {
      return 'Age at onset: ${onsetAge!.value?.toString()} ${onsetAge!.unit}';
    } else if (onsetRange != null) {
      return 'Range: ${onsetRange!.low?.value?.toString()} to ${onsetRange!.high?.value?.toString()}';
    } else if (onsetString != null) {
      return onsetString!;
    }
    return 'Onset unknown';
  }

  String getResolutionDateTime() =>
      abatementDateTime?.toIso8601String() ??
      abatementPeriod?.start?.toIso8601String() ??
      'Resolution unknown';

  String getNotes() => note?.map((e) => e.text).join(', ') ?? ''.hardcoded;

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
