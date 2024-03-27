import 'package:fhir_r4/fhir_r4.dart';
import 'package:collection/collection.dart';
import 'package:ips/entry_from_bundle.dart';

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

  factory ResultDisplay.fromObservation(Observation observation) {
    return ResultDisplay(
      resultType: observation.code.text ??
          observation.code.coding?.firstOrNull?.display,
      resultValue: observation.valueQuantity?.value?.toString() ??
          observation.valueString,
      resultInterpretation:
          observation.interpretation?.firstOrNull?.coding?.firstOrNull?.display,
      observationMethod: observation.method?.text ??
          observation.method?.coding?.firstOrNull?.display,
      effectiveDateTime: observation.effectiveDateTime?.value,
      notes: observation.note?.map((e) => e.text).join(' '),
    );
  }

  factory ResultDisplay.fromDiagnosticReport(
      DiagnosticReport diagnosticReport, Bundle bundle) {
    // Initialize default values
    String? primaryResultValue;
    DateTime? effectiveDateTime;
    String? notes;

    // Attempt to extract more detailed information from the first result, if available
    if (diagnosticReport.result?.isNotEmpty == true) {
      final Observation? primaryObservation =
          bundle.resourceFromBundle(diagnosticReport.result!.first.reference)
              as Observation?;

      if (primaryObservation != null) {
        primaryResultValue =
            primaryObservation.valueQuantity?.value?.toString() ??
                primaryObservation.valueString;
        effectiveDateTime = primaryObservation.effectiveDateTime?.value;
        notes = primaryObservation.note?.map((e) => e.text).join(' ');
      }
    }

    return ResultDisplay(
      resultType: diagnosticReport.code.text ??
          diagnosticReport.code.coding?.firstOrNull?.display,
      resultValue: primaryResultValue,
      effectiveDateTime: effectiveDateTime,
      notes: notes,
    );
  }

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
