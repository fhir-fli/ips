import 'package:fhir_r6/fhir_r6.dart';

extension ConditionFunctionalStatusR6 on Condition {
  String getStatus() => clinicalStatus.coding?.firstOrNull?.display ?? '--';

  String getSeverity() => severity?.coding?.firstOrNull?.display ?? '--';

  String getCodeDisplay() =>
      code?.text ?? code?.coding?.firstOrNull?.display ?? '--';

  String getBodySite() =>
      bodySite?.firstOrNull?.text ??
      bodySite?.firstOrNull?.coding?.firstOrNull?.display ??
      '--';

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

  String getNotes() => note?.map((e) => e.text).join(', ') ?? '--';
}

extension ClinicalImpressionFunctionalStatusR6 on ClinicalImpression {
  String getStatus() => status?.value ?? '--';

  String getCodeDisplay() {
    final findingsText = finding
        ?.map((f) =>
            f.item?.concept?.text ??
            f.item?.concept?.coding?.firstOrNull?.display)
        .join(', ');
    return findingsText ?? '--';
  }

  String getOnsetDateTime() => date?.value.toIso8601String() ?? '--';

  String getNotes() => summary?.value ?? '--';
}
