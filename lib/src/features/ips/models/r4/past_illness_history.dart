import 'package:fhir_r4/fhir_r4.dart';

extension ConditionPastIllnessR4 on Condition {
  String getConditionName() =>
      code?.text ?? code?.coding?.firstOrNull?.display ?? '--';

  String getClinicalStatus() =>
      clinicalStatus?.coding?.firstOrNull?.display ?? '--';

  String getVerificationStatus() =>
      verificationStatus?.coding?.firstOrNull?.display ?? '--';

  String getSeverity() => severity?.coding?.firstOrNull?.display ?? '--';

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

  String getNotes() => note?.map((e) => e.text).join(', ') ?? '--';
}
