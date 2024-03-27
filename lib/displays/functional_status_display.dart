import 'package:fhir_r4/fhir_r4.dart';
import 'package:collection/collection.dart';

class FunctionalStatusDisplay {
  String? status;
  String? severity;
  String? codeDisplay;
  String? bodySite;
  DateTime? onsetDateTime;
  String? notes;

  FunctionalStatusDisplay({
    this.status,
    this.severity,
    this.codeDisplay,
    this.bodySite,
    this.onsetDateTime,
    this.notes,
  });

  factory FunctionalStatusDisplay.fromCondition(Condition condition) {
    return FunctionalStatusDisplay(
      status: condition.clinicalStatus?.coding?.firstOrNull?.display,
      severity: condition.severity?.coding?.firstOrNull?.display,
      codeDisplay:
          condition.code?.text ?? condition.code?.coding?.firstOrNull?.display,
      bodySite: condition.bodySite?.firstOrNull?.text ??
          condition.bodySite?.firstOrNull?.coding?.firstOrNull?.display,
      onsetDateTime: condition.onsetDateTime?.value,
      notes: condition.note?.map((e) => e.text).join(' '),
    );
  }

  factory FunctionalStatusDisplay.fromClinicalImpression(
      ClinicalImpression clinicalImpression, Bundle bundle) {
    String? findings;
    // Potentially, clinicalImpression.finding could contain relevant information
    if (clinicalImpression.finding?.isNotEmpty ?? false) {
      findings = clinicalImpression.finding!
          .map((f) =>
              f.itemCodeableConcept?.text ??
              f.itemCodeableConcept?.coding?.firstOrNull?.display)
          .join(', ');
    }

    return FunctionalStatusDisplay(
      status: clinicalImpression.status?.value,
      // Severity might not directly map, but interpretation or findings might give clues
      codeDisplay: findings,
      onsetDateTime: clinicalImpression.date?.value,
      notes: clinicalImpression.summary,
    );
  }

  @override
  String toString() {
    final parts = [
      if (status != null) 'Status: $status',
      if (severity != null) 'Severity: $severity',
      if (codeDisplay != null) 'Condition: $codeDisplay',
      if (bodySite != null) 'Body Site: $bodySite',
      if (onsetDateTime != null)
        'Onset Date: ${onsetDateTime!.toIso8601String()}',
      if (notes != null) 'Notes: $notes',
    ];
    return parts.join(', ');
  }
}
