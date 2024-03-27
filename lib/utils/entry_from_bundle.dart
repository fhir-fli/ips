import 'package:collection/collection.dart';
import 'package:fhir_r4/fhir_r4.dart';

extension BundleExtension on Bundle {
  Resource? resourceFromBundle(String? reference) {
    if (reference == null) {
      return null;
    }
    return entry
        ?.firstWhereOrNull((entry) =>
            entry.fullUrl.toString() == reference ||
            entry.resource?.path == reference)
        ?.resource;
  }
}
