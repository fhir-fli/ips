import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IpsScreen extends ConsumerStatefulWidget {
  const IpsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IpsScreenState();
}

class _IpsScreenState extends ConsumerState<IpsScreen> {
  @override
  Widget build(BuildContext context) {
    final drawer = Drawer(
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text('Item $index'),
          onTap: () {
            // Update the state of the app
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        padding: EdgeInsets.zero,
      ),
    );
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: const Text('IPS'),
      ),
      body: const Center(
        child: Text('IPS View'),
      ),
    );
  }
}
