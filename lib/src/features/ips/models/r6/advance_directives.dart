import 'package:collection/collection.dart';
import 'package:fhir_r6/fhir_r6.dart';

extension ConsentAdvanceDirectiveR6 on Consent {
  String getStatus() => status?.value ?? "Unknown";

  String getCategory() =>
      category?.firstOrNull?.coding?.firstOrNull?.display ?? '--';

  String getDateTime() => date?.value.toIso8601String() ?? 'Date unknown';

  String getOrganization(Bundle bundle) {
    if (manager != null && manager!.isNotEmpty) {
      final reference = manager!.first.reference ?? '';
      final referencedResource = bundle.entry
          ?.firstWhereOrNull((entry) => entry.fullUrl?.value == reference)
          ?.resource;
      if (referencedResource is Organization) {
        return referencedResource.name ?? '--';
      }
    }
    if (controller != null && controller!.isNotEmpty) {
      final reference = controller!.first.reference ?? '';
      final referencedResource = bundle.entry
          ?.firstWhereOrNull((entry) => entry.fullUrl?.value == reference)
          ?.resource;
      if (referencedResource is Organization) {
        return referencedResource.name ?? '--';
      }
    }
    return '--';
  }

  String getSourceAttachment() =>
      sourceAttachment?.firstOrNull?.title ??
      sourceReference?.firstOrNull?.display ??
      '--';

  String getNotes() => text?.div.value ?? '--';
}
