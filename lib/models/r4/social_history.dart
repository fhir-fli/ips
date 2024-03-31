import 'package:fhir_r4/fhir_r4.dart';

extension ObservationSocialHistoryR4 on Observation {
  String getSocialFactor() =>
      code.text ?? code.coding?.firstOrNull?.display ?? '--';

  String getValue() {
    if (valueQuantity != null) {
      return '${valueQuantity!.value?.toString()} ${valueQuantity!.unit}';
    } else if (valueCodeableConcept != null) {
      return valueCodeableConcept!.text ??
          valueCodeableConcept!.coding?.firstOrNull?.display ??
          '--';
    } else if (valueString != null) {
      return valueString!;
    }
    return '--';
  }

  String getObservationDate() =>
      effectiveDateTime?.value.toIso8601String() ?? 'Date unknown';

  String getNotes() => note?.map((e) => e.text).join(', ') ?? '--';
}
