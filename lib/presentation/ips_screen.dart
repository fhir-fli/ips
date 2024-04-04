import 'package:fhir_r4/fhir_r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

class IpsScreen extends ConsumerWidget {
  final IpsDataR4 person;

  const IpsScreen(this.person);

  Widget buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget buildListTile(String content, BuildContext context) {
    return ListTile(
      title: Text(
        content,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      tileColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person.patient?.name?.firstOrNull?.family ?? ''),
      ),
      body: ListView(
        children: [
          buildSectionHeader(context, 'Allergies'),
          ...person.allergies
              .map((a) => a.display(person.bundle))
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          buildSectionHeader(context, 'Medications'),
          ...person.medications
              .map((e) => e is MedicationStatement
                  ? e.display(person.bundle)
                  : e is MedicationRequest
                      ? e.display(person.bundle)
                      : e is MedicationDispense
                          ? e.display(person.bundle)
                          : e is MedicationAdministration
                              ? e.display(person.bundle)
                              : null)
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Problems'),
          ...person.problems
              .map((a) => ConditionProblemR4(a).display())
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Vital Signs'),
          ...person.vitalSigns
              .map((a) => ObservationVitalSignR4(a).display())
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Past Illness History'),
          ...person.pastIllnessHx
              .map((a) => ConditionPastIllnessR4(a).display())
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Pregnancy History'),
          ...person.pregnancyHx
              .map((a) => ObservationPregnancyR4(a).display())
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Medication Devices'),
          ...person.medicationDevices
              .map((a) => a.display(person.bundle))
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Procedures'),
          ...person.procedures
              .map((a) => a.display())
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Social History'),
          ...person.socialHistory
              .map((a) => ObservationSocialHistoryR4(a).display())
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Results'),
          ...person.results
              .map((a) => ObservationResultsR4(a).display())
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Immunizations'),
          ...person.immunizations
              .map((a) => a.display())
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Functional Status'),
          ...person.functionalStatus
              .map((e) => e is Condition
                  ? ConditionFunctionalStatusR4(e).display()
                  : (e as ClinicalImpression).display())
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Plan of Care'),
          ...person.planOfCare
              .map((a) => a.display())
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
          Divider(),
          buildSectionHeader(context, 'Advance Directives'),
          ...person.advanceDirectives
              .map((a) => a.display(person.bundle))
              .whereType<String>()
              .where((element) => element.isNotEmpty)
              .map((e) => buildListTile(e, context))
              .toSet()
              .toList(),
        ],
      ),
    );
  }
}
