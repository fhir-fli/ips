import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen();

  Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              const SizedBox(width: 24),
              Text('Loading...'.hardcoded),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController hapiController = TextEditingController();
    TextEditingController ipsController = TextEditingController();

    Widget rowButton(
            TextEditingController controller, String text, String url) =>
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child:
                      Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    showLoadingDialog(context);
                    final successful = await ref
                        .read(personListControllerProvider.notifier)
                        .downloadFromUrl(url, controller.text);
                    Navigator.pop(context);
                    if (successful) {
                      Navigator.pop(context);
                    } else {
                      showAlertDialog(
                          context: context,
                          title:
                              'There was an error downloading the data. Please try again.'
                                  .hardcoded);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Enter ID",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              rowButton(hapiController, 'Download from HAPI FHIR Server',
                  'http://hapi.fhir.org/baseR4'),
              SizedBox(height: 30),
              rowButton(ipsController, 'Download from IPS Reference Server',
                  'https://hl7-ips-server.hl7.org/fhir'),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text('Load Demo Data',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () async {
                  showLoadingDialog(context);
                  await ref
                      .read(personListControllerProvider.notifier)
                      .download();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
