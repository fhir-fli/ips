import 'package:fhir_r4/fhir_r4.dart';
import 'package:collection/collection.dart';

class ProblemDisplay {
  String? conditionName;
  String? clinicalStatus;
  String? verificationStatus;
  String? severity;
  String? onsetDateTime;
  String? notes;

  ProblemDisplay({
    this.conditionName,
    this.clinicalStatus,
    this.verificationStatus,
    this.severity,
    this.onsetDateTime,
    this.notes,
  });

  factory ProblemDisplay.fromCondition(Condition condition) {
    return ProblemDisplay()
      ..conditionName =
          condition.code?.text ?? condition.code?.coding?.firstOrNull?.display
      ..clinicalStatus = condition.clinicalStatus?.coding?.firstOrNull?.display
      ..verificationStatus =
          condition.verificationStatus?.coding?.firstOrNull?.display
      ..severity = condition.severity?.coding?.firstOrNull?.display
      ..onsetDateTime = _parseOnset(condition)
      ..notes = condition.note?.map((e) => e.text).join(' ');
  }

  static String? _parseOnset(Condition condition) {
    if (condition.onsetDateTime != null) {
      return condition.onsetDateTime!.toIso8601String();
    } else if (condition.onsetPeriod != null) {
      return '${condition.onsetPeriod!.start?.toIso8601String()} to ${condition.onsetPeriod!.end?.toIso8601String()}';
    } else if (condition.onsetAge != null) {
      return 'Age at onset: ${condition.onsetAge!.value?.toString()} ${condition.onsetAge!.unit}';
    } else if (condition.onsetRange != null) {
      return 'Range: ${condition.onsetRange!.low?.value?.toString()} to ${condition.onsetRange!.high?.value?.toString()}';
    } else if (condition.onsetString != null) {
      return condition.onsetString;
    }
    return null;
  }

  @override
  String toString() {
    final parts = [
      if (conditionName != null) 'Condition: $conditionName',
      if (clinicalStatus != null) 'Clinical Status: $clinicalStatus',
      if (verificationStatus != null)
        'Verification Status: $verificationStatus',
      if (severity != null) 'Severity: $severity',
      if (onsetDateTime != null) 'Onset: $onsetDateTime',
      if (notes != null) 'Notes: $notes',
    ];
    return parts.join(', ');
  }
}
