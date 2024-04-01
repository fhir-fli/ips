import 'package:fhir_r4/fhir_r4.dart';
import '../../ips.dart';

extension ImmunizationR4 on Immunization {
  String getVaccineName() =>
      vaccineCode.text ?? vaccineCode.coding?.first.display ?? ''.hardcoded;

  String getVaccinationDate() => (occurrenceDateTime != null)
      ? occurrenceDateTime!.toIso8601String()
      : (occurrenceString != null)
          ? occurrenceString!
          : 'Date unknown';

  String getStatus() => status?.value ?? ''.hardcoded;

  String display() {
    List<String> parts = [
      getVaccineName(),
      getVaccinationDate(),
      getStatus(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
