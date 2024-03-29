import 'package:collection/collection.dart';
import 'package:fhir_r5/fhir_r5.dart';

extension BundleR5 on Bundle {
  Resource? resourceFromBundleByReference(String? reference) {
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
