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
