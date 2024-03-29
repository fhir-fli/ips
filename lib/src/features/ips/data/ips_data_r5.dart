import 'package:collection/collection.dart';
import 'package:fhir_primitives/fhir_primitives.dart';
import 'package:fhir_r5/fhir_r5.dart';

import '../../../../ips.dart';

class IpsDataR5 {
  final Bundle bundle;
  Composition? composition;
  Patient? patient;
  final Map<IpsSection, String> sectionLoincCodes = {
    IpsSection.medications: '10160-0',
    IpsSection.allergies: '48765-2',
    IpsSection.problems: '11450-4',
    IpsSection.procedures: '47519-4',
    IpsSection.immunizations: '11369-6',
    IpsSection.medicationDevices: '46264-8',
    IpsSection.results: '30954-2',
    IpsSection.vitalSigns: '8716-3',
    IpsSection.pastIllnessHx: '11348-0',
    IpsSection.functionalStatus: '47420-5',
    IpsSection.planOfCare: '18776-5',
    IpsSection.socialHistory: '29762-2',
    IpsSection.pregnancyHx: '10162-6',
    IpsSection.advanceDirectives: '42348-3',
  };

  IpsDataR5(this.bundle) {
    _parseComposition();
    _parsePatient();
  }

  void _parseComposition() {
    composition = bundle.entry
        ?.map((entry) => entry.resource)
        .whereType<Composition>()
        .firstWhereOrNull((composition) =>
            composition.type.coding?.any((coding) =>
                coding.system == FhirUri('http://loinc.org') &&
                coding.code == FhirCode('60591-5')) ??
            false);
  }

  void _parsePatient() {
    patient = bundle.resourceFromBundleByReference(
        composition?.subject?.firstOrNull?.reference) as Patient?;
  }

  CompositionSection? getSection(IpsSection section) =>
      composition?.section?.firstWhereOrNull((element) =>
          element.code?.coding?.firstOrNull?.code?.value ==
          sectionLoincCodes[section]);

  List<String> sectionEntries(CompositionSection? section) =>
      section?.entry?.map((e) => e.reference).whereType<String>().toList() ??
      <String>[];

  List<Resource> sectionResources(IpsSection section) {
    final compositionSection = getSection(section);
    final references = sectionEntries(compositionSection);
    return references
        .map((ref) => bundle.resourceFromBundleByReference(ref))
        .whereType<Resource>()
        .toList();
  }

  List<Resource> get medications => sectionResources(IpsSection.medications);

  List<AllergyIntolerance> get allergies =>
      sectionResources(IpsSection.allergies) as List<AllergyIntolerance>;

  List<Condition> get problems =>
      sectionResources(IpsSection.problems) as List<Condition>;

  List<Procedure> get procedures =>
      sectionResources(IpsSection.procedures) as List<Procedure>;

  List<Immunization> get immunizations =>
      sectionResources(IpsSection.immunizations) as List<Immunization>;

  List<DeviceUsage> get medicationDevices =>
      sectionResources(IpsSection.medicationDevices) as List<DeviceUsage>;

  List<Observation> get results =>
      sectionResources(IpsSection.results) as List<Observation>;

  List<Observation> get vitalSigns =>
      sectionResources(IpsSection.vitalSigns) as List<Observation>;

  List<Condition> get pastIllnessHx =>
      sectionResources(IpsSection.pastIllnessHx) as List<Condition>;

  List<Resource> get functionalStatus =>
      sectionResources(IpsSection.functionalStatus);

  List<CarePlan> get planOfCare =>
      sectionResources(IpsSection.planOfCare) as List<CarePlan>;

  List<Observation> get socialHistory =>
      sectionResources(IpsSection.socialHistory) as List<Observation>;

  List<Observation> get pregnancyHx =>
      sectionResources(IpsSection.pregnancyHx) as List<Observation>;

  List<Consent> get advanceDirectives =>
      sectionResources(IpsSection.advanceDirectives) as List<Consent>;
}
