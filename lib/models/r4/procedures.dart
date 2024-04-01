import 'package:fhir_r4/fhir_r4.dart';
import '../../ips.dart';

extension ProcedureR4 on Procedure {
  String getProcedureName() =>
      code?.text ?? code?.coding?.first.display ?? ''.hardcoded;

  String getStatus() => status?.value ?? ''.hardcoded;

  String getPerformedDateTime() => (performedPeriod?.start != null)
      ? performedPeriod!.start!.toIso8601String()
      : (performedDateTime != null)
          ? performedDateTime!.toIso8601String()
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
