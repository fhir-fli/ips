import 'package:collection/collection.dart';
import 'package:fhir_r5/fhir_r5.dart';

import 'models.dart';

class IpsDataR5 {
  final Bundle bundle;

  IpsDataR5(this.bundle);

  Composition? get composition => bundle.getComposition();

  Patient? get patient => bundle.resourceFromBundleByReference(
      composition?.subject?.firstOrNull?.reference) as Patient?;

  CompositionSection? getSection(IpsSection section) =>
      composition?.section?.firstWhereOrNull((element) =>
          element.code?.coding?.firstOrNull?.code?.value ==
          sectionLoincCodes[section]);

  List<String> sectionEntries(CompositionSection? section) =>
      section?.entry?.map((e) => e.reference).whereType<String>().toList() ??
      <String>[];

  List<T> sectionResources<T>(IpsSection section) {
    final compositionSection = getSection(section);
    final references = sectionEntries(compositionSection);
    return references
        .map((ref) => bundle.resourceFromBundleByReference(ref))
        .whereType<T>()
        .toList();
  }

  List<Resource> get medications =>
      sectionResources<Resource>(IpsSection.medications);

  List<AllergyIntolerance> get allergies =>
      sectionResources<AllergyIntolerance>(IpsSection.allergies);

  List<Condition> get problems =>
      sectionResources<Condition>(IpsSection.problems);

  List<Procedure> get procedures =>
      sectionResources<Procedure>(IpsSection.procedures);

  List<Immunization> get immunizations =>
      sectionResources<Immunization>(IpsSection.immunizations);

  List<DeviceUsage> get medicationDevices =>
      sectionResources<DeviceUsage>(IpsSection.medicationDevices);

  List<Observation> get results =>
      sectionResources<Observation>(IpsSection.results);

  List<Observation> get vitalSigns =>
      sectionResources<Observation>(IpsSection.vitalSigns);

  List<Condition> get pastIllnessHx =>
      sectionResources<Condition>(IpsSection.pastIllnessHx);

  List<Resource> get functionalStatus =>
      sectionResources<Resource>(IpsSection.functionalStatus);

  List<CarePlan> get planOfCare =>
      sectionResources<CarePlan>(IpsSection.planOfCare);

  List<Observation> get socialHistory =>
      sectionResources<Observation>(IpsSection.socialHistory);

  List<Observation> get pregnancyHx =>
      sectionResources<Observation>(IpsSection.pregnancyHx);

  List<Consent> get advanceDirectives =>
      sectionResources<Consent>(IpsSection.advanceDirectives);
}
