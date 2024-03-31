import 'package:fhir_r4/fhir_r4.dart';

extension CarePlanR4 on CarePlan {
  String getCategory() =>
      category?.firstOrNull?.text ??
      category?.firstOrNull?.coding?.firstOrNull?.display ??
      '--';

  String getSummary() => description ?? '--';

  String getStatus() => status?.value ?? '--';

  String getStartDate() =>
      period?.start?.value.toIso8601String() ?? 'Not specified';

  String getEndDate() =>
      period?.end?.value.toIso8601String() ?? 'Not specified';

  String getIntent() => intent?.value ?? '--';
}
