class PlanOfCareDisplay {
  String? category;
  String? summary;
  String? status;
  DateTime? startDate;
  DateTime? endDate;
  String? intent;

  PlanOfCareDisplay({
    this.category,
    this.summary,
    this.status,
    this.startDate,
    this.endDate,
    this.intent,
  });

  @override
  String toString() {
    final startDateStr = startDate?.toIso8601String() ?? 'Not specified';
    final endDateStr = endDate?.toIso8601String() ?? 'Not specified';
    return 'Category: $category, Summary: $summary, Status: $status, Start Date: $startDateStr, End Date: $endDateStr, Intent: $intent';
  }
}
