class MedicationDeviceDisplay {
  String? deviceName;
  String? status;
  DateTime? timing;
  String? reason;

  MedicationDeviceDisplay({
    this.deviceName,
    this.status,
    this.timing,
    this.reason,
  });

  @override
  String toString() {
    final timingStr = timing?.toIso8601String() ?? 'Timing unknown';
    return 'Device Name: $deviceName, Status: $status, Timing: $timingStr, Reason: $reason';
  }
}
