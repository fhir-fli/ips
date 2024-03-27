import 'package:fhir_r4/fhir_r4.dart';

class VitalSignsDisplay {
  String? vitalSignType;
  String? value;
  DateTime? observationDate;
  String? unit;

  VitalSignsDisplay({
    this.vitalSignType,
    this.value,
    this.observationDate,
    this.unit,
  });

  factory VitalSignsDisplay.fromObservation(Observation observation) {
    String? observationValue;
    if (observation.valueQuantity != null) {
      observationValue =
          '${observation.valueQuantity?.value} ${observation.valueQuantity?.unit}';
    } else if (observation.valueCodeableConcept != null) {
      observationValue = observation.valueCodeableConcept?.text ??
          observation.valueCodeableConcept?.coding?.firstOrNull?.display;
    }

    return VitalSignsDisplay(
      vitalSignType: observation.code.text ??
          observation.code.coding?.firstOrNull?.display,
      value: observationValue,
      observationDate: observation.effectiveDateTime?.value,
      unit: observation.valueQuantity?.unit,
    );
  }

  @override
  String toString() {
    final dateStr = observationDate?.toIso8601String() ?? 'Date unknown';
    return 'Vital Sign: $vitalSignType, Value: $value, Date: $dateStr, Unit: $unit';
  }
}
