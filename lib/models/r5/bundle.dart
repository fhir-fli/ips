import 'package:collection/collection.dart';
import 'package:fhir_primitives/fhir_primitives.dart';
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

  Composition? getComposition() => entry
      ?.map((entry) => entry.resource)
      .whereType<Composition>()
      .firstWhereOrNull((composition) =>
          composition.type.coding?.any((coding) =>
              coding.system == FhirUri('http://loinc.org') &&
              coding.code == FhirCode('60591-5')) ??
          false);
}
