import 'package:fhir_r6/fhir_r6.dart';

extension ObservationPregnancyR6 on Observation {
  String getObservationType() =>
      code.text ?? code.coding?.first.display ?? '--';

  String getValue() {
    if (valueQuantity != null) {
      return '${valueQuantity!.value?.toString()} ${valueQuantity!.unit}';
    } else if (valueCodeableConcept != null) {
      return valueCodeableConcept!.text ??
          valueCodeableConcept!.coding?.first.display ??
          '--';
    } else if (valueString != null) {
      return valueString!;
    }
    return '--';
  }

  String getObservationDate() =>
      effectiveDateTime?.toIso8601String() ?? 'Date unknown';

  String getNotes() => note?.map((n) => n.text ?? '--').join('; ') ?? '--';
}
