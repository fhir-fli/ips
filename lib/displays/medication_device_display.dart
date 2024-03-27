import 'package:fhir_r4/fhir_r4.dart';
import 'package:ips/entry_from_bundle.dart';

class MedicationDevicesDisplay {
  String? deviceName;
  String? status;
  DateTime? timing;
  String? reason;

  MedicationDevicesDisplay({
    this.deviceName,
    this.status,
    this.timing,
    this.reason,
  });

  factory MedicationDevicesDisplay.fromDeviceUseStatement(
      DeviceUseStatement deviceUseStatement, Bundle bundle) {
    // Assuming the device reference is correctly formatted and exists within the same bundle
    String deviceReference = deviceUseStatement.device.reference ?? '';
    Device? device = bundle.resourceFromBundle(deviceReference) as Device?;

    // Constructing the reason from the reasonCode field
    String? reasons = deviceUseStatement.reasonCode
        ?.map((code) => code.text ?? code.coding?.firstOrNull?.display)
        .join(", ");

    return MedicationDevicesDisplay(
      deviceName:
          device?.type?.text ?? device?.type?.coding?.firstOrNull?.display,
      status: deviceUseStatement.status?.value,
      timing: deviceUseStatement.timingDateTime?.value ??
          deviceUseStatement.timingPeriod?.start?.value,
      reason: reasons,
    );
  }

  @override
  String toString() {
    final timingStr = timing?.toIso8601String() ?? 'Timing unknown';
    return 'Device Name: $deviceName, Status: $status, Timing: $timingStr, Reason: $reason';
  }
}
