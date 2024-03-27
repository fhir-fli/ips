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
