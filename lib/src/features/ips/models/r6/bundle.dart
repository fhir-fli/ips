import 'package:collection/collection.dart';
import 'package:fhir_r6/fhir_r6.dart';

extension BundleR6 on Bundle {
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
