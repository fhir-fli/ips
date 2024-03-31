import 'package:fhir_r4/fhir_r4.dart';

extension ConditionR4 on Condition {
  String getConditionName() =>
      code?.text ?? code?.coding?.first.display ?? '--';

  String getClinicalStatus() => clinicalStatus?.coding?.first.display ?? '--';

  String getVerificationStatus() =>
      verificationStatus?.coding?.first.display ?? '--';

  String getSeverity() => severity?.coding?.first.display ?? '--';

  String getOnsetDateTime() {
    if (onsetDateTime != null) {
      return onsetDateTime!.toIso8601String();
    } else if (onsetPeriod != null) {
      final start = onsetPeriod!.start?.toIso8601String() ?? '--';
      final end = onsetPeriod!.end?.toIso8601String() ?? '--';
      return '$start to $end';
    } else if (onsetAge != null) {
      return 'Age at onset: ${onsetAge!.value?.toString()} ${onsetAge!.unit}';
    } else if (onsetRange != null) {
      final low = onsetRange!.low?.value?.toString() ?? '--';
      final high = onsetRange!.high?.value?.toString() ?? '--';
      return 'Range: $low to $high';
    } else if (onsetString != null) {
      return onsetString!;
    }
    return '--';
  }

  String getNotes() => note?.map((n) => n.text ?? '--').join('; ') ?? '--';
}
