import 'package:fhir_r4/fhir_r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

class PersonScreen extends ConsumerWidget {
  const PersonScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final persons = ref.watch(personListControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(persons.length, (index) {
                final HumanName? humanName =
                    persons[index].patient?.name?.firstOrNull;
                final firstName = humanName?.given?.join(' ');
                final name =
                    '${firstName == null ? "" : firstName} ${humanName?.family == null ? "" : humanName?.family}';
                return OutlinedButton(
                  child: Center(
                    child: Text(
                      name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IpsScreen(persons[index])),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      floatingActionButton: IconButton(
        icon: Column(
          children: [
            const Icon(Icons.download),
            Text('Download'),
          ],
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DownloadScreen()),
        ),
      ),
    );
  }
}
