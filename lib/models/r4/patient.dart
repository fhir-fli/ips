import 'package:fhir_r4/fhir_r4.dart';

extension PatientR4 on Patient {
  String printName() {
    final HumanName? humanName = this.name?.firstOrNull;
    final firstName = humanName?.given?.join(' ');
    return '${firstName == null ? "" : firstName} ${humanName?.family == null ? "" : humanName?.family}';
  }
}
