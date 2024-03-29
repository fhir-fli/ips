import 'package:collection/collection.dart';
import 'package:fhir_primitives/fhir_primitives.dart';
import 'package:fhir_r6/fhir_r6.dart';

import '../../../../ips.dart';

class IpsDataR6 {
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

  IpsDataR6(this.bundle) {
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
