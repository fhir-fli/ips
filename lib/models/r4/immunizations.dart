import 'package:fhir_r4/fhir_r4.dart';

extension ImmunizationR4 on Immunization {
  String getVaccineName() =>
      vaccineCode.text ?? vaccineCode.coding?.first.display ?? '--';

  String getVaccinationDate() => (occurrenceDateTime != null)
      ? occurrenceDateTime!.toIso8601String()
      : (occurrenceString != null)
          ? occurrenceString!
          : 'Date unknown';

  String getStatus() => status?.value ?? '--';
}
