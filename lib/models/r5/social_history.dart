import 'package:fhir_r5/fhir_r5.dart';
import '../../ips.dart';

extension ObservationSocialHistoryR5 on Observation {
  String getSocialFactor() =>
      code.text ?? code.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getValue() {
    if (valueQuantity != null) {
      return '${valueQuantity!.value?.toString()} ${valueQuantity!.unit}';
    } else if (valueCodeableConcept != null) {
      return valueCodeableConcept!.text ??
          valueCodeableConcept!.coding?.firstOrNull?.display ??
          ''.hardcoded;
    } else if (valueString != null) {
      return valueString!;
    }
    return ''.hardcoded;
  }

  String getObservationDate() =>
      effectiveDateTime?.value.toIso8601String() ?? 'Date unknown';

  String getNotes() => note?.map((e) => e.text).join(', ') ?? ''.hardcoded;
}
