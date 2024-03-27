import 'package:fhir_r4/fhir_r4.dart';

class ProceduresDisplay {
  String? procedureName;
  String? status;
  DateTime? performedDateTime;
  String? performer;
  String? location;

  ProceduresDisplay({
    this.procedureName,
    this.status,
    this.performedDateTime,
    this.performer,
    this.location,
  });

  factory ProceduresDisplay.fromProcedure(Procedure procedure) {
    return ProceduresDisplay(
      procedureName:
          procedure.code?.text ?? procedure.code?.coding?.firstOrNull?.display,
      status: procedure.status?.value,
      performedDateTime: procedure.performedDateTime?.value,
      performer: procedure.performer?.firstOrNull?.actor.display,
      location: procedure.location?.display,
    );
  }

  @override
  String toString() {
    final parts = [
      if (procedureName != null) 'Procedure: $procedureName',
      if (status != null) 'Status: $status',
      if (performedDateTime != null)
        'Date: ${performedDateTime!.toIso8601String()}',
      if (performer != null) 'Performed by: $performer',
      if (location != null) 'Location: $location',
    ];
    return parts.join(', ');
  }
}
