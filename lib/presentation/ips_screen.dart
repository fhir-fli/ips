import 'package:fhir_r4/fhir_r4.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../ips.dart';

class IpsScreen extends ConsumerWidget {
  final IpsDataR4 person;
  const IpsScreen(this.person);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextStyle headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      decorationThickness: 1,
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(person.patient?.name?.firstOrNull?.family ?? ''),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text(
                'Allergies',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.allergies
                    .map((a) => a.display(person.bundle))
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Medications',
                style: headerStyle,
              ),
            ),
            Column(
              children: person.medications
                  .map((e) => e is MedicationStatement
                      ? e.display(person.bundle)
                      : (e as MedicationRequest).display(person.bundle))
                  .whereType<String>()
                  .where((element) => element.isNotEmpty)
                  .map((e) => ListTile(title: Text(e)))
                  .toList(),
            ),
            ListTile(
              title: Text(
                'Problems',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.problems
                    .map((a) => ConditionProblemR4(a).display())
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Vital Signs',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.vitalSigns
                    .map((a) => ObservationVitalSignR4(a).display())
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Past Illness History',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.pastIllnessHx
                    .map((a) => ConditionPastIllnessR4(a).display())
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Pregnancy History',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.pregnancyHx
                    .map((a) => ObservationPregnancyR4(a).display())
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Medication Devices',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.medicationDevices
                    .map((a) => a.display(person.bundle))
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Procedures',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.procedures
                    .map((a) => a.display())
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Social History',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.socialHistory
                    .map((a) => ObservationSocialHistoryR4(a).display())
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Results',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.results
                    .map((a) => ObservationResultsR4(a).display())
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Immunizations',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.immunizations
                    .map((a) => a.display())
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Functional Status',
                style: headerStyle,
              ),
            ),
            Column(
              children: person.functionalStatus
                  .map((e) => e is Condition
                      ? ConditionFunctionalStatusR4(e).display()
                      : (e as ClinicalImpression).display())
                  .whereType<String>()
                  .where((element) => element.isNotEmpty)
                  .map((e) => ListTile(title: Text(e)))
                  .toList(),
            ),
            ListTile(
              title: Text(
                'Plan of Care',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.planOfCare
                    .map((a) => a.display())
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text(
                'Advance Directives',
                style: headerStyle,
              ),
            ),
            Column(
                children: person.advanceDirectives
                    .map((a) => a.display(person.bundle))
                    .whereType<String>()
                    .where((element) => element.isNotEmpty)
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
          ],
        ));
  }
}
