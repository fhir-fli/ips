class FunctionalStatusDisplay {
  String? status;
  String? severity;
  String? codeDisplay;
  String? bodySite;
  DateTime? onsetDateTime;
  String? notes;

  FunctionalStatusDisplay({
    this.status,
    this.severity,
    this.codeDisplay,
    this.bodySite,
    this.onsetDateTime,
    this.notes,
  });
  @override
  String toString() {
    final parts = [
      if (status != null) 'Status: $status',
      if (severity != null) 'Severity: $severity',
      if (codeDisplay != null) 'Condition: $codeDisplay',
      if (bodySite != null) 'Body Site: $bodySite',
      if (onsetDateTime != null)
        'Onset Date: ${onsetDateTime!.toIso8601String()}',
      if (notes != null) 'Notes: $notes',
    ];
    return parts.join(', ');
  }
}
