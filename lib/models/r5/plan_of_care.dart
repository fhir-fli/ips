import 'package:fhir_r5/fhir_r5.dart';
import '../../ips.dart';

extension CarePlanR5 on CarePlan {
  String getCategory() =>
      category?.firstOrNull?.text ??
      category?.firstOrNull?.coding?.firstOrNull?.display ??
      ''.hardcoded;

  String getSummary() => description ?? ''.hardcoded;

  String getStatus() => status?.value ?? ''.hardcoded;

  String getStartDate() =>
      period?.start?.value.toIso8601String() ?? 'Not specified';

  String getEndDate() =>
      period?.end?.value.toIso8601String() ?? 'Not specified';

  String getIntent() => intent?.value ?? ''.hardcoded;

  String display() {
    List<String> parts = [
      getCategory(),
      getSummary(),
      getStatus(),
      getStartDate(),
      getEndDate(),
      getIntent(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
