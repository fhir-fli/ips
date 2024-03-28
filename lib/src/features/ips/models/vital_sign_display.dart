class VitalSignDisplay {
  String? vitalSignType;
  String? value;
  DateTime? observationDate;
  String? unit;

  VitalSignDisplay({
    this.vitalSignType,
    this.value,
    this.observationDate,
    this.unit,
  });

  @override
  String toString() {
    final dateStr = observationDate?.toIso8601String() ?? 'Date unknown';
    return 'Vital Sign: $vitalSignType, Value: $value, Date: $dateStr, Unit: $unit';
  }
}
