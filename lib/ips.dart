import 'package:collection/collection.dart';
import 'package:fhir_primitives/fhir_primitives.dart';
import 'package:fhir_r4/fhir_r4.dart';
import 'package:ips/entry_from_bundle.dart';
import 'package:ips/displays/medication_display.dart';

import 'ips_sections.dart';

class Ips {
  final Bundle bundle;
  Composition? composition;
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

  Ips(this.bundle) {
    _parseComposition();
    _parseSectionReferences();
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

  void printPatient() {
    final patientReference = composition?.subject?.reference;
    if (patientReference != null) {
      final Patient? patient =
          bundle.resourceFromBundle(patientReference) as Patient?;
      if (patient?.name != null && patient!.name!.isNotEmpty) {
        print((patient.name!.first.given?.join(' ') ?? '') +
            ' ' +
            (patient.name!.first.family ?? ''));
      }
      if (patient?.birthDate != null) {
        print('DOB: ${patient!.birthDate!.value}');
      }
    }
  }

  void printAllergies() {
    final allergies = sectionReferences[IpsSections.allergies];
    print('ALLERGIES:');
    for (final allergy in allergies ?? <String>[]) {
      final resource = bundle.resourceFromBundle(allergy);
      if (resource != null && resource is AllergyIntolerance) {
        final coding = resource.code?.coding
            ?.firstWhereOrNull((coding) => coding.display != null);
        print(coding?.display ?? '');
      }
    }
  }

  void printMedications() {
    final medications = sectionReferences[IpsSections.medications];
    if (medications != null) {
      print('MEDICATIONS:');
      for (final medication in medications) {
        MedicationDisplay medicationDisplay;
        final resource = bundle.resourceFromBundle(medication);
        if (resource != null) {
          if (resource is MedicationStatement) {
            medicationDisplay =
                MedicationDisplay.fromMedicationStatement(resource, bundle);
            print(medicationDisplay);
          }
        } else if (resource is MedicationRequest) {
          medicationDisplay =
              MedicationDisplay.fromMedicationRequest(resource, bundle);
          print(medicationDisplay);
        }
      }
    }
  }

  void printProblems() {
    final problems = sectionReferences[IpsSections.problems];
    print('PROBLEMS:');
    for (final problem in problems ?? <String>[]) {
      final resource = bundle.resourceFromBundle(problem);
      if (resource != null && resource is Condition) {
        final coding = resource.code?.coding
            ?.firstWhereOrNull((coding) => coding.display != null);
        print(coding?.display ?? '');
      }
    }
  }
}
