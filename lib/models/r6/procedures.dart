import 'package:fhir_r6/fhir_r6.dart';

extension ProcedureR6 on Procedure {
  String getProcedureName() =>
      code?.text ?? code?.coding?.first.display ?? '--';

  String getStatus() => status?.value ?? '--';

  String getPerformedDateTime() => (occurrencePeriod?.start != null)
      ? occurrencePeriod!.start!.toIso8601String()
      : (occurrencePeriod != null)
          ? occurrenceDateTime!.toIso8601String()
          : 'Date unknown';

  String getPerformer() => performer?.first.actor.display ?? '--';

  String getLocation() => location?.display ?? '--';
}
