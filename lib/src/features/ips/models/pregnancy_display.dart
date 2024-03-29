class PregnancyDisplay {
  String? observationType;
  String? value;
  DateTime? observationDate;
  String? notes;

  PregnancyDisplay({
    this.observationType,
    this.value,
    this.observationDate,
    this.notes,
  });

  @override
  String toString() {
    final dateStr = observationDate?.toIso8601String() ?? 'Date unknown';
    return 'Vital Sign: $observationType, Value: $value, Date: $dateStr, Notes: $notes';
  }
}
