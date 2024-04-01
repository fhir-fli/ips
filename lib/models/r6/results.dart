import 'package:fhir_r6/fhir_r6.dart';
import '../../ips.dart';

extension ObservationR6 on Observation {
  String getResultType() =>
      code.text ?? code.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getResultValue() {
    if (valueQuantity != null) {
      return '${valueQuantity!.value?.toString()} ${valueQuantity!.unit}';
    } else if (valueCodeableConcept != null) {
      return valueCodeableConcept!.coding?.firstOrNull?.display ??
          valueCodeableConcept!.text ??
          ''.hardcoded;
    } else if (valueString != null) {
      return valueString!;
    } else if (valueBoolean != null) {
      return valueBoolean!.toString();
    }
    return ''.hardcoded;
  }

  String getResultInterpretation() =>
      interpretation
          ?.map((i) => i.coding?.firstOrNull?.display ?? i.text ?? ''.hardcoded)
          .join(', ') ??
      ''.hardcoded;

  String getObservationMethod() =>
      method?.text ?? method?.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getEffectiveDateTime() {
    if (effectiveDateTime != null) {
      return effectiveDateTime!.toIso8601String();
    } else if (effectivePeriod != null) {
      return '${effectivePeriod!.start?.toIso8601String()} to ${effectivePeriod!.end?.toIso8601String()}';
    }
    return 'Date unknown';
  }

  String getNotes() =>
      note?.map((n) => n.text ?? ''.hardcoded).join(', ') ?? ''.hardcoded;
}
