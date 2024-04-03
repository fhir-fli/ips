import 'package:fhir_r6/fhir_r6.dart';

extension PatientR6 on Patient {
  String printName() {
    final HumanName? humanName = this.name?.firstOrNull;
    final firstName = humanName?.given?.join(' ');
    return '${firstName == null ? "" : firstName} ${humanName?.family == null ? "" : humanName?.family}';
  }
}
