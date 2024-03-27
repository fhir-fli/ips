import 'package:fhir_r4/fhir_r4.dart';

class AllergyDisplay {
  String? allergen;
  String? clinicalStatus;
  String? verificationStatus;
  String? reaction;
  String? criticality;

  AllergyDisplay({
    this.allergen,
    this.clinicalStatus,
    this.verificationStatus,
    this.reaction,
    this.criticality,
  });

  factory AllergyDisplay.fromAllergyIntolerance(AllergyIntolerance allergy) {
    return AllergyDisplay(
      allergen:
          allergy.code?.text ?? allergy.code?.coding?.firstOrNull?.display,
      clinicalStatus: allergy.clinicalStatus?.coding?.firstOrNull?.display,
      verificationStatus:
          allergy.verificationStatus?.coding?.firstOrNull?.display,
      reaction: allergy.reaction
          ?.map((r) => r.manifestation
              .map((m) => m.coding?.firstOrNull?.display ?? m.text)
              .join(', '))
          .join('; '),
      criticality: allergy.criticality?.value,
    );
  }

  @override
  String toString() {
    final parts = [
      if (allergen != null) 'Allergen: $allergen',
      if (clinicalStatus != null) 'Clinical Status: $clinicalStatus',
      if (verificationStatus != null)
        'Verification Status: $verificationStatus',
      if (reaction != null) 'Reaction: $reaction',
      if (criticality != null) 'Criticality: $criticality',
    ];
    return parts.join(', ');
  }
}
