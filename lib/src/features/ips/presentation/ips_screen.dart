import 'package:fhir_r4/fhir_r4.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ips/src/features/ips/presentation/ips_screen_controller.dart';
import 'package:ips/src/src.dart';

class IpsScreen extends ConsumerStatefulWidget {
  const IpsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IpsScreenState();
}

class _IpsScreenState extends ConsumerState<IpsScreen> {
  @override
  void initState() {
    super.initState();

    /// Attempt to login as soon as the widget is built
    /// This is only called once, so it's safe to call it here
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ipsPeopleListControllerProvider.notifier).loadPeople();
    });
  }

  @override
  Widget build(BuildContext context) {
    final peopleList = ref.watch(ipsPeopleListControllerProvider).when(
        data: (data) => data,
        error: (e, s) => <IpsDataR4>[],
        loading: () => <IpsDataR4>[]);
    final activePerson = ref.watch(activeIpsPersonControllerProvider);
    return Scaffold(
        drawer: Drawer(
          child: ListView.builder(
            itemCount: peopleList.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                  peopleList[index].patient?.name?.firstOrNull?.family ?? ''),
              onTap: () {
                ref
                    .read(activeIpsPersonControllerProvider.notifier)
                    .activatePerson(peopleList[index]);
                Navigator.of(context).pop();
              },
            ),
            padding: EdgeInsets.zero,
          ),
        ),
        appBar: AppBar(
          title: const Text('IPS'),
        ),
        body: activePerson == null
            ? const Center(child: Text('IPS View'))
            : IpsDisplay(activePerson));
  }
}

class IpsDisplay extends ConsumerWidget {
  final IpsDataR4 person;
  const IpsDisplay(this.person);

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
