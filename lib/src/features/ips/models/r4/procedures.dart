import 'package:fhir_r4/fhir_r4.dart';

extension ProcedureR4 on Procedure {
  String getProcedureName() =>
      code?.text ?? code?.coding?.first.display ?? '--';

  String getStatus() => status?.value ?? '--';

  String getPerformedDateTime() => (performedPeriod?.start != null)
      ? performedPeriod!.start!.toIso8601String()
      : (performedDateTime != null)
          ? performedDateTime!.toIso8601String()
          : 'Date unknown';

  String getPerformer() => performer?.first.actor.display ?? '--';

  String getLocation() => location?.display ?? '--';
}
