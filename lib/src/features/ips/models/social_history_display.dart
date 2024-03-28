class SocialHistoryDisplay {
  String? socialFactor;
  String? value;
  DateTime? observationDate;
  String? notes;

  SocialHistoryDisplay({
    this.socialFactor,
    this.value,
    this.observationDate,
    this.notes,
  });

  @override
  String toString() {
    final dateStr = observationDate?.toIso8601String() ?? 'Date unknown';
    return 'Social Factor: $socialFactor, Value: $value, Date: $dateStr, Notes: $notes';
  }
}
