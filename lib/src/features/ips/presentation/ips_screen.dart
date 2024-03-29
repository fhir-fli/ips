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
    return Scaffold(
      drawer: Drawer(
        child: ListView.builder(
          itemCount: peopleList.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
                peopleList[index].patient?.name?.firstOrNull?.family ?? ''),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      appBar: AppBar(
        title: const Text('IPS'),
      ),
      body: const Center(
        child: Text('IPS View'),
      ),
    );
  }
}
