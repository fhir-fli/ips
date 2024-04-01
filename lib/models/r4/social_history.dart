import 'package:fhir_r4/fhir_r4.dart';
import '../../ips.dart';

extension ObservationSocialHistoryR4 on Observation {
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

  String display() {
    List<String> parts = [
      getSocialFactor(),
      getValue(),
      getObservationDate(),
      getNotes(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
