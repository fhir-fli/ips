class ProcedureDisplay {
  String? procedureName;
  String? status;
  DateTime? performedDateTime;
  String? performer;
  String? location;

  ProcedureDisplay({
    this.procedureName,
    this.status,
    this.performedDateTime,
    this.performer,
    this.location,
  });

  @override
  String toString() {
    final parts = [
      if (procedureName != null) 'Procedure: $procedureName',
      if (status != null) 'Status: $status',
      if (performedDateTime != null)
        'Date: ${performedDateTime!.toIso8601String()}',
      if (performer != null) 'Performed by: $performer',
      if (location != null) 'Location: $location',
    ];
    return parts.join(', ');
  }
}
