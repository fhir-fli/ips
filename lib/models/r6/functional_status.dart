import 'package:fhir_r6/fhir_r6.dart';
import '../../ips.dart';

extension ConditionFunctionalStatusR6 on Condition {
  String getStatus() =>
      clinicalStatus.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getSeverity() =>
      severity?.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getCodeDisplay() =>
      code?.text ?? code?.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getBodySite() =>
      bodySite?.firstOrNull?.text ??
      bodySite?.firstOrNull?.coding?.firstOrNull?.display ??
      ''.hardcoded;

  String getOnsetDateTime() {
    if (onsetDateTime != null) {
      return onsetDateTime!.toIso8601String();
    } else if (onsetPeriod != null) {
      return '${onsetPeriod!.start?.toIso8601String()} to ${onsetPeriod!.end?.toIso8601String()}';
    } else if (onsetAge != null) {
      return 'Age at onset: ${onsetAge!.value?.toString()} ${onsetAge!.unit}';
    } else if (onsetRange != null) {
      return 'Range: ${onsetRange!.low?.value?.toString()} to ${onsetRange!.high?.value?.toString()}';
    } else if (onsetString != null) {
      return onsetString!;
    }
    return 'Onset unknown';
  }

  String getNotes() => note?.map((e) => e.text).join(', ') ?? ''.hardcoded;

  String display() {
    List<String> parts = [
      getStatus(),
      getSeverity(),
      getCodeDisplay(),
      getBodySite(),
      getOnsetDateTime(),
      getNotes(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}

extension ClinicalImpressionFunctionalStatusR6 on ClinicalImpression {
  String getStatus() => status?.value ?? ''.hardcoded;

  String getCodeDisplay() {
    final findingsText = finding
        ?.map((f) =>
            f.item?.concept?.text ??
            f.item?.concept?.coding?.firstOrNull?.display)
        .join(', ');
    return findingsText ?? ''.hardcoded;
  }

  String getOnsetDateTime() => date?.value.toIso8601String() ?? ''.hardcoded;

  String getNotes() => summary?.value ?? ''.hardcoded;

  String display() {
    List<String> parts = [
      getStatus(),
      getCodeDisplay(),
      getOnsetDateTime(),
      getNotes(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
