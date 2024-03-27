class ImmunizationDisplay {
  String? vaccineName;
  DateTime? vaccinationDate;
  String? status;

  ImmunizationDisplay({
    this.vaccineName,
    this.vaccinationDate,
    this.status,
  });

  @override
  String toString() {
    final dateStr = vaccinationDate?.toIso8601String() ?? 'Date unknown';
    return 'Vaccine: $vaccineName, Date: $dateStr, Status: $status';
  }
}
