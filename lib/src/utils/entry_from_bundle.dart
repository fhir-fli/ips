import 'package:collection/collection.dart';
import 'package:fhir_dstu2/fhir_dstu2.dart' as dstu2;
import 'package:fhir_r4/fhir_r4.dart' as r4;
import 'package:fhir_r5/fhir_r5.dart' as r5;
import 'package:fhir_r6/fhir_r6.dart' as r6;
import 'package:fhir_stu3/fhir_stu3.dart' as stu3;

extension Dstu2BundleExtension on dstu2.Bundle {
  dstu2.Resource? resourceFromBundle(String? reference) {
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

extension R4BundleExtension on r4.Bundle {
  r4.Resource? resourceFromBundle(String? reference) {
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

extension R5BundleExtension on r5.Bundle {
  r5.Resource? resourceFromBundle(String? reference) {
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

extension r6BundleExtension on r6.Bundle {
  r6.Resource? resourceFromBundle(String? reference) {
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

extension Stu3BundleExtension on stu3.Bundle {
  stu3.Resource? resourceFromBundle(String? reference) {
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
