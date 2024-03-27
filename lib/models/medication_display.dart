class MedicationDisplay {
  String? medicationName;
  String? medicationForm;
  String? routeOfAdministration;
  String? dosingTiming;
  String? doseQuantity;
  String? instructions;

  MedicationDisplay({
    this.medicationName,
    this.medicationForm,
    this.routeOfAdministration,
    this.dosingTiming,
    this.doseQuantity,
    this.instructions,
  });

  @override
  String toString() {
    final parts = [
      if (medicationName != null) 'Medication: $medicationName',
      if (medicationForm != null) 'Form: $medicationForm',
      if (routeOfAdministration != null) 'Route: $routeOfAdministration',
      if (dosingTiming != null) 'Timing: $dosingTiming',
      if (doseQuantity != null) 'Dose: $doseQuantity',
      if (instructions != null) 'Instructions: $instructions',
    ];
    return parts.join(', ');
  }
}
