import 'package:fhir_r4/fhir_r4.dart';

class ImmunizationsDisplay {
  String? vaccineName;
  DateTime? vaccinationDate;
  String? status;

  ImmunizationsDisplay({
    this.vaccineName,
    this.vaccinationDate,
    this.status,
  });

  factory ImmunizationsDisplay.fromImmunization(Immunization immunization) {
    return ImmunizationsDisplay(
      vaccineName: immunization.vaccineCode.text ??
          immunization.vaccineCode.coding?.firstOrNull?.display,
      vaccinationDate: immunization.occurrenceDateTime?.value,
      status: immunization.status?.value,
    );
  }

  @override
  String toString() {
    final dateStr = vaccinationDate?.toIso8601String() ?? 'Date unknown';
    return 'Vaccine: $vaccineName, Date: $dateStr, Status: $status';
  }
}
