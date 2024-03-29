import 'package:fhir_r5/fhir_r5.dart';

extension ObservationR5 on Observation {
  String getResultType() =>
      code.text ?? code.coding?.firstOrNull?.display ?? '--';

  String getResultValue() {
    if (valueQuantity != null) {
      return '${valueQuantity!.value?.toString()} ${valueQuantity!.unit}';
    } else if (valueCodeableConcept != null) {
      return valueCodeableConcept!.coding?.firstOrNull?.display ??
          valueCodeableConcept!.text ??
          '--';
    } else if (valueString != null) {
      return valueString!;
    } else if (valueBoolean != null) {
      return valueBoolean!.toString();
    }
    return '--';
  }

  String getResultInterpretation() =>
      interpretation
          ?.map((i) => i.coding?.firstOrNull?.display ?? i.text ?? '--')
          .join(', ') ??
      '--';

  String getObservationMethod() =>
      method?.text ?? method?.coding?.firstOrNull?.display ?? '--';

  String getEffectiveDateTime() {
    if (effectiveDateTime != null) {
      return effectiveDateTime!.toIso8601String();
    } else if (effectivePeriod != null) {
      return '${effectivePeriod!.start?.toIso8601String()} to ${effectivePeriod!.end?.toIso8601String()}';
    }
    return 'Date unknown';
  }

  String getNotes() => note?.map((n) => n.text ?? '--').join(', ') ?? '--';
}
