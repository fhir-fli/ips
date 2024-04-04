import 'dart:convert';

import 'package:fhir_r4/fhir_r4.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../ips.dart';

part 'person_list_controller.g.dart';

@riverpod
class PersonListController extends _$PersonListController {
  @override
  List<IpsDataR4> build() => [];

  void set(List<IpsDataR4> value) => state = value;

  Future<void> download() async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final filePaths = jsonDecode(manifestJson)
        .keys
        .where((String key) => key.startsWith('assets/samples'));
    final personList = <IpsDataR4>[];
    for (final filePath in filePaths) {
      try {
        String jsonString = await rootBundle.loadString(filePath);
        final resource = Resource.fromJsonString(jsonString);
        if (resource is Bundle) {
          personList.add(IpsDataR4(resource));
        }
      } catch (e) {
        print(e);
      }
    }
    state = personList;
  }

  Future<bool> downloadFromUrl(String url, String id) async {
    try {
      final result = await http.get(Uri.parse('$url/Patient/$id/\$summary'));
      final resource = Resource.fromJsonString(result.body);
      if (resource is Bundle) {
        state = [...state, IpsDataR4(resource)];
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
