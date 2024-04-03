import 'package:fhir_r5/fhir_r5.dart';

extension PatientR5 on Patient {
  String printName() {
    final HumanName? humanName = this.name?.firstOrNull;
    final firstName = humanName?.given?.join(' ');
    return '${firstName == null ? "" : firstName} ${humanName?.family == null ? "" : humanName?.family}';
  }
}
