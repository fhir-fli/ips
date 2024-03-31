import 'package:fhir_r4/fhir_r4.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../ips.dart';

class IpsScreen extends ConsumerWidget {
  final IpsDataR4 person;
  const IpsScreen(this.person);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String allergiesDisplay(AllergyIntolerance allergy) =>
        '${allergy.getAllergen()} - ${allergy.getClinicalStatus()} - ${allergy.getVerificationStatus()} - ${allergy.getReaction()} - ${allergy.getCriticality()}';
    String? medicationsDisplay(Resource resource) => resource
            is MedicationRequest
        ? '${resource.getMedicationName(person.bundle)} - ${resource.getMedicationForm(person.bundle)} - ${resource.getRouteOfAdministration()} - ${resource.getDosingTiming()} - ${resource.getDoseQuantity()} - ${resource.getInstructions()}'
        : resource is MedicationStatement
            ? '${resource.getMedicationName(person.bundle)} - ${resource.getMedicationForm(person.bundle)} - ${resource.getRouteOfAdministration()} - ${resource.getDosingTiming()} - ${resource.getDoseQuantity()} - ${resource.getInstructions()}'
            : null;

    return Scaffold(
        appBar: AppBar(
          title: Text(person.patient?.name?.firstOrNull?.family ?? ''),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('Allergies'),
            ),
            Column(
                children: person.allergies
                    .map((a) => allergiesDisplay(a))
                    .whereType<String>()
                    .map((e) => ListTile(title: Text(e)))
                    .toList()),
            ListTile(
              title: Text('Medications'),
            ),
            Column(
              children: person.medications
                  .map((e) => medicationsDisplay(e))
                  .whereType<String>()
                  .map((e) => ListTile(title: Text(e)))
                  .toList(),
            ),
            ListTile(
              title: Text('Problems'),
            ),
            ListTile(
              title: Text('Vital Signs'),
            ),
            ListTile(
              title: Text('Past Illness History'),
            ),
            ListTile(
              title: Text('Pregnancy History'),
            ),
            ListTile(
              title: Text('Medication Devices'),
            ),
            ListTile(
              title: Text('Procedures'),
            ),
            ListTile(
              title: Text('Social History'),
            ),
            ListTile(
              title: Text('Results'),
            ),
            ListTile(
              title: Text('Immunizations'),
            ),
            ListTile(
              title: Text('Functional Status'),
            ),
            ListTile(
              title: Text('Plan of Care'),
            ),
            ListTile(
              title: Text('Advance Directives'),
            ),
          ],
        ));
  }
}
