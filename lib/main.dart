import 'dart:io';

import 'package:fhir_r4/fhir_r4.dart';
import 'package:ips/ips.dart';

void main() {
  final Directory directory = Directory('validated_samples');
  final List<File> files = directory.listSync().whereType<File>().toList();
  for (final file in files) {
    final String content = file.readAsStringSync();
    final resource = Resource.fromJsonString(content);
    if (resource is Bundle) {
      final Ips parser = Ips(resource);
      parser.printPatient();
      parser.printAllergies();
      parser.printMedications();
      parser.printProblems();
    }
  }
}
