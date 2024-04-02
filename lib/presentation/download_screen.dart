import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController hapiController = TextEditingController();
    TextEditingController ipsController = TextEditingController();
    final screenSize = MediaQuery.of(context).size;

    Widget rowButton(
            TextEditingController controller, String text, String url) =>
        Column(
          children: [
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(text,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              onPressed: () async {
                ref
                    .read(personListControllerProvider.notifier)
                    .downloadFromUrl(url, controller.text);
              },
            ),
            SizedBox(
              width: screenSize.width * 0.3,
              child: TextField(
                controller: controller,
              ),
            ),
          ],
        );
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                rowButton(
                    hapiController,
                    'Enter an ID to download from https://hapi.fhir.org/',
                    'http://hapi.fhir.org/baseR4'),
                rowButton(
                    ipsController,
                    'Enter an ID to download from the IPS Reference Server',
                    'https://hl7-ips-server.hl7.org/fhir'),
                OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Load Demo Data',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall),
                  ),
                  onPressed: () async {
                    ref.read(personListControllerProvider.notifier).download();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
