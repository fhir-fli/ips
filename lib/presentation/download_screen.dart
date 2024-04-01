import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

class DownloadScreen extends ConsumerWidget {
  const DownloadScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: ElevatedButton(
              child: Text(
                'Load Demo Data',
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
              onPressed: () async {
                ref.read(personListControllerProvider.notifier).download();
              },
            ),
          ),
        ),
      ),
    );
  }
}
