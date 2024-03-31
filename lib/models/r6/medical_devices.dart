import 'package:fhir_r6/fhir_r6.dart';
import 'package:ips/models/models.dart';

extension DeviceUseStatementR6 on DeviceUsage {
  String getDeviceName(Bundle bundle) {
    final Device? actualDevice = bundle
        .resourceFromBundleByReference(device.reference?.reference) as Device?;
    return actualDevice?.type?.firstOrNull?.text ??
        actualDevice?.type?.firstOrNull?.coding?.firstOrNull?.display ??
        '--';
  }

  String getStatus() => status?.value ?? '--';

  String getTiming() {
    if (timingDateTime != null) {
      return timingDateTime!.toIso8601String();
    } else if (timingPeriod != null && timingPeriod!.start != null) {
      return timingPeriod!.start!.toIso8601String();
    } else if (timingTiming != null &&
        (timingTiming!.event?.isNotEmpty ?? false)) {
      return timingTiming!.event!.first.toIso8601String();
    }
    return 'Timing unknown';
  }

  String getReason(Bundle bundle) {
    if (reason?.isNotEmpty ?? false) {
      return reason!
          .map((code) =>
              code.concept?.text ??
              code.concept?.coding?.firstOrNull?.display ??
              '--')
          .join(", ");
    }
    return '--';
  }
}