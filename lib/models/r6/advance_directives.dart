import 'package:collection/collection.dart';
import 'package:fhir_r6/fhir_r6.dart';
import '../../ips.dart';

extension ConsentAdvanceDirectiveR6 on Consent {
  String getStatus() => status?.value ?? "Unknown";

  String getCategory() =>
      category?.firstOrNull?.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getDateTime() => date?.value.toIso8601String() ?? 'Date unknown';

  String getOrganization(Bundle bundle) {
    if (manager != null && manager!.isNotEmpty) {
      final reference = manager!.first.reference ?? '';
      final referencedResource = bundle.entry
          ?.firstWhereOrNull((entry) => entry.fullUrl?.value == reference)
          ?.resource;
      if (referencedResource is Organization) {
        return referencedResource.name ?? ''.hardcoded;
      }
    }
    if (controller != null && controller!.isNotEmpty) {
      final reference = controller!.first.reference ?? '';
      final referencedResource = bundle.entry
          ?.firstWhereOrNull((entry) => entry.fullUrl?.value == reference)
          ?.resource;
      if (referencedResource is Organization) {
        return referencedResource.name ?? ''.hardcoded;
      }
    }
    return ''.hardcoded;
  }

  String getSourceAttachment() =>
      sourceAttachment?.firstOrNull?.title ??
      sourceReference?.firstOrNull?.display ??
      ''.hardcoded;

  String getNotes() => text?.div.value ?? ''.hardcoded;

  String display(Bundle bundle) {
    List<String> parts = [
      getStatus(),
      getCategory(),
      getDateTime(),
      getOrganization(bundle),
      getSourceAttachment(),
      getNotes(),
    ].where((part) => part.isNotEmpty).toList();
    return parts.join(' - ');
  }
}
