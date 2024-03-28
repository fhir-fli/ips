class PastIllnessHistoryDisplay {
  String? conditionName;
  String? clinicalStatus;
  String? verificationStatus;
  String? severity;
  DateTime? onsetDateTime;
  String? resolutionDateTime;
  String? notes;

  PastIllnessHistoryDisplay({
    this.conditionName,
    this.clinicalStatus,
    this.verificationStatus,
    this.severity,
    this.onsetDateTime,
    this.resolutionDateTime,
    this.notes,
  });

  @override
  String toString() {
    final onsetStr = onsetDateTime?.toIso8601String() ?? 'Onset unknown';
    final resolutionStr = resolutionDateTime ?? 'Resolution unknown';
    return 'Condition: $conditionName, Status: $clinicalStatus, Severity: $severity, Onset: $onsetStr, Resolution: $resolutionStr, Notes: $notes';
  }
}
