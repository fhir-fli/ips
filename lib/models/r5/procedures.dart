import 'package:fhir_r5/fhir_r5.dart';

extension ProcedureR5 on Procedure {
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
