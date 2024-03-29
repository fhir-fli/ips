import 'dart:convert';

import 'package:fhir_r4/fhir_r4.dart';
import 'package:flutter/services.dart';
import 'package:ips/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ips_screen_controller.g.dart';

@riverpod
class IpsPeopleListController extends _$IpsPeopleListController
    with NotifierMounted {
  @override
  FutureOr<List<IpsDataR4>> build() {
    ref.onDispose(setUnmounted);
    return <IpsDataR4>[];
  }

  Future<void> loadPeople() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        final manifestJson = await rootBundle.loadString('AssetManifest.json');
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
        return personList;
      },
    );
  }
}

@riverpod
class ActiveIpsPersonController extends _$ActiveIpsPersonController
    with NotifierMounted {
  @override
  IpsDataR4? build() => null;

  void activatePerson(IpsDataR4 data) {
    state = data;
  }
}
