import 'dart:convert';

import 'package:fhir_r4/fhir_r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: TextButton(
              child: Text('Load Demo Data'),
              onPressed: () async {
                final manifestJson =
                    await rootBundle.loadString('AssetManifest.json');
                final filePaths = jsonDecode(manifestJson)
                    .keys
                    .where((String key) => key.startsWith('assets/samples'));
                final personList = <IpsDataR4>[];
                for (final filePath in filePaths) {
                  String jsonString = await rootBundle.loadString(filePath);
                  final resource = Resource.fromJsonString(jsonString);
                  if (resource is Bundle) {
                    personList.add(IpsDataR4(resource));
                  }
                }
                ref.read(personListControllerProvider.notifier).set(personList);
              },
            ),
          ),
        ),
      ),
    );
  }
}
