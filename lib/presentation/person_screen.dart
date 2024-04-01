import 'package:fhir_r4/fhir_r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

class PersonScreen extends ConsumerWidget {
  const PersonScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final persons = ref.watch(personListControllerProvider);
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            actions: [
              IconButton(
                color: Colors.white,
                icon: Row(
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
                  MaterialPageRoute(
                      builder: (context) => const DownloadScreen()),
                ),
              )
            ],
          ),
          body: Center(
            child: persons.length == 0
                ? Text('No Patient Summaries Found',
                    style: Theme.of(context).textTheme.headlineSmall)
                : GridView.count(
                    crossAxisCount: screenSize.width < 500
                        ? 2
                        : screenSize.width < 800
                            ? 3
                            : 4,
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
                                builder: (context) =>
                                    IpsScreen(persons[index])),
                          ),
                        ),
                      );
                    }),
                  ),
          ),
        ),
      ),
    );
  }
}
