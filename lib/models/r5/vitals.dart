import 'package:fhir_r5/fhir_r5.dart';

extension ObservationVitalSignR5 on Observation {
  String getVitalSignType() =>
      code.text ?? code.coding?.firstOrNull?.display ?? '--';

  String getValue() {
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

  String getObservationDate() =>
      effectiveDateTime?.toIso8601String() ??
      effectivePeriod?.start?.toIso8601String() ??
      'Date unknown';

  String getUnit() => valueQuantity?.unit ?? '--';
}