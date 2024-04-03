import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

class PersonScreen extends ConsumerWidget {
  const PersonScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final persons = ref.watch(personListControllerProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            actions: [
              IconButton(
                color: Theme.of(context).colorScheme.onSecondary,
                icon: Row(
                  children: [
                    const Icon(Icons.download),
                    Text(
                      'Download'.hardcoded,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary),
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
            child:
                persons.length == 0 ? NoPatientButton() : PersonList(persons),
          ),
        ),
      ),
    );
  }
}

class NoPatientButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          side: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DownloadScreen())),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Use the minimum space
          children: <Widget>[
            Icon(Icons.cloud_download,
                size: 48.0, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(
                height: 10), // Provides space between the icon and the text
            Text(
              'No Patient Summaries Found\nClick Here to Download'.hardcoded,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonList extends StatelessWidget {
  const PersonList(this.persons);

  final List<IpsDataR4> persons;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenSize.width < 500
                  ? 2
                  : screenSize.width < 800
                      ? 3
                      : 4,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 2.0, // Adjusted for better fit of content
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final patient = persons[index].patient;
                return Card(
                  elevation: 4.0,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IpsScreen(persons[index]),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      child: Center(
                        child: Text(
                          patient?.printName() ?? '',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow
                              .ellipsis, // Helps to manage long text
                          maxLines: 2, // Allows text up to two lines
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: persons.length,
            ),
          ),
        ),
      ],
    );
  }
}
