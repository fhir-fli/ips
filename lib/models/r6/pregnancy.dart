import 'package:fhir_r6/fhir_r6.dart';
import '../../ips.dart';

extension ObservationPregnancyR6 on Observation {
  String getObservationType() =>
      code.text ?? code.coding?.first.display ?? ''.hardcoded;

  String getValue() {
    if (valueQuantity != null) {
      return '${valueQuantity!.value?.toString()} ${valueQuantity!.unit}';
    } else if (valueCodeableConcept != null) {
      return valueCodeableConcept!.text ??
          valueCodeableConcept!.coding?.first.display ??
          ''.hardcoded;
    } else if (valueString != null) {
      return valueString!;
    }
    return ''.hardcoded;
  }

  String getObservationDate() =>
      effectiveDateTime?.toIso8601String() ?? 'Date unknown';

  String getNotes() =>
      note?.map((n) => n.text ?? ''.hardcoded).join('; ') ?? ''.hardcoded;

  String display() {
    List<String> parts = [
      getObservationType(),
      getValue(),
      getObservationDate(),
      getNotes(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
