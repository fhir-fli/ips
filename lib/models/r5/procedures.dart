import 'package:fhir_r5/fhir_r5.dart';
import '../../ips.dart';

extension ProcedureR5 on Procedure {
  String getProcedureName() =>
      code?.text ?? code?.coding?.first.display ?? ''.hardcoded;

  String getStatus() => status?.value ?? ''.hardcoded;

  String getPerformedDateTime() => (occurrencePeriod?.start != null)
      ? occurrencePeriod!.start!.toIso8601String()
      : (occurrencePeriod != null)
          ? occurrenceDateTime!.toIso8601String()
          : 'Date unknown';

  String getPerformer() => performer?.first.actor.display ?? ''.hardcoded;

  String getLocation() => location?.display ?? ''.hardcoded;

  String display() {
    List<String> parts = [
      getProcedureName(),
      getStatus(),
      getPerformedDateTime(),
      getPerformer(),
      getLocation(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
