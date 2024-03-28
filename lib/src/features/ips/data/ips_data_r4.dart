import 'package:collection/collection.dart';
import 'package:fhir_primitives/fhir_primitives.dart';
import 'package:fhir_r4/fhir_r4.dart';

import '../ips.dart';

class IpsDataR4 {
  final Bundle bundle;
  Composition? composition;
  Patient? patient;
  final Map<IpsSections, List<String>> sectionReferences = {};
  final Map<String, IpsSections> loincToSection = {
    '10160-0': IpsSections.medications,
    '48765-2': IpsSections.allergies,
    '11450-4': IpsSections.problems,
    '47519-4': IpsSections.procedures,
    '11369-6': IpsSections.immunizations,
    '46264-8': IpsSections.medicationDevices,
    '30954-2': IpsSections.results,
    '8716-3': IpsSections.vitalSigns,
    '11348-0': IpsSections.pastIllnessHx,
    '47420-5': IpsSections.functionalStatus,
    '18776-5': IpsSections.planOfCare,
    '29762-2': IpsSections.socialHistory,
    '10162-6': IpsSections.pregnancyHx,
    '42348-3': IpsSections.advanceDirectives,
  };

  IpsDataR4(this.bundle) {
    _parseComposition();
    _parseSectionReferences();
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

  void _parseSectionReferences() {
    composition?.section?.forEach((section) {
      final coding = section.code?.coding?.firstWhereOrNull(
          (Coding coding) => loincToSection.containsKey(coding.code?.value));
      if (coding != null) {
        final sectionType = loincToSection[coding.code!.value!];
        if (sectionType != null) {
          final stringList = <String>[];
          section.entry?.forEach((entry) {
            if (entry.reference != null) {
              stringList.add(entry.reference!);
            }
          });
          sectionReferences[sectionType] = stringList;
        }
      }
    });
  }

  void _parsePatient() {
    patient =
        bundle.resourceFromBundle(composition?.subject?.reference) as Patient?;
  }
}
