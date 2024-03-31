import 'package:fhir_r5/fhir_r5.dart';

extension ImmunizationR5 on Immunization {
  String getVaccineName() =>
      vaccineCode.text ?? vaccineCode.coding?.first.display ?? '--';

  String getVaccinationDate() => (occurrenceDateTime != null)
      ? occurrenceDateTime!.toIso8601String()
      : (occurrenceString != null)
          ? occurrenceString!
          : 'Date unknown';

  String getStatus() => status?.value ?? '--';
}
