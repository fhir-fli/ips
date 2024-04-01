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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
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
                  ),
                );
              }),
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 90.0,
        height: 90.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.purple,
        ),
        child: IconButton(
          color: Colors.white,
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.download),
              Text(
                'Download',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DownloadScreen()),
          ),
        ),
      ),
    );
  }
}
