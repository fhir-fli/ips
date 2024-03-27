class ResultDisplay {
  String? resultType;
  String? resultValue;
  String? resultInterpretation;
  String? observationMethod;
  DateTime? effectiveDateTime;
  String? notes;

  ResultDisplay({
    this.resultType,
    this.resultValue,
    this.resultInterpretation,
    this.observationMethod,
    this.effectiveDateTime,
    this.notes,
  });

  @override
  String toString() {
    final parts = [
      if (resultType != null) 'Type: $resultType',
      if (resultValue != null) 'Value: $resultValue',
      if (resultInterpretation != null) 'Interpretation: $resultInterpretation',
      if (observationMethod != null) 'Method: $observationMethod',
      if (effectiveDateTime != null)
        'Date: ${effectiveDateTime!.toIso8601String()}',
      if (notes != null) 'Notes: $notes',
    ];
    return parts.join(', ');
  }
}
