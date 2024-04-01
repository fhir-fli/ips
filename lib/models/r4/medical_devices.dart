import 'package:fhir_r4/fhir_r4.dart';
import '../../ips.dart';

extension DeviceUseStatementR4 on DeviceUseStatement {
  String getDeviceName(Bundle bundle) {
    final Device? actualDevice =
        bundle.resourceFromBundleByReference(device.reference) as Device?;
    return actualDevice?.type?.text ??
        actualDevice?.type?.coding?.firstOrNull?.display ??
        ''.hardcoded;
  }

  String getStatus() => status?.value ?? ''.hardcoded;

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
    if (reasonCode?.isNotEmpty ?? false) {
      return reasonCode!
          .map((code) =>
              code.text ?? code.coding?.firstOrNull?.display ?? ''.hardcoded)
          .join(", ");
    } else if (reasonReference?.isNotEmpty ?? false) {
      return reasonReference!.map((reference) {
        // TODO(Dokotela)
        final referencedResource =
            bundle.resourceFromBundleByReference(reference.reference);
        // This part depends on the type of resources expected in
        //reasonReference and how you'd like to extract a "reason" from them
        // Placeholder for specific logic
        return ''.hardcoded; // Placeholder return value
      }).join(", ");
    }
    return 'Reason unknown';
  }

  String display(Bundle bundle) {
    List<String> parts = [
      getDeviceName(bundle),
      getStatus(),
      getTiming(),
      getReason(bundle),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
