import 'package:collection/collection.dart';
import 'package:fhir_r4/fhir_r4.dart';
import '../../ips.dart';

extension ConsentAdvanceDirectiveR4 on Consent {
  String getStatus() => status?.value ?? "Unknown";

  String getCategory() =>
      category.firstOrNull?.coding?.firstOrNull?.display ?? ''.hardcoded;

  String getDateTime() => dateTime?.value.toIso8601String() ?? 'Date unknown';

  String getOrganization(Bundle bundle) {
    if (organization != null && organization!.isNotEmpty) {
      final reference = organization!.first.reference ?? '';
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
      sourceAttachment?.title ?? sourceReference?.display ?? ''.hardcoded;

  String getNotes() => text?.div ?? ''.hardcoded;

  String display(Bundle bundle) {
    List<String> parts = [
      'Status: ${getStatus()}',
      if (getCategory().isNotEmpty) 'Category: ${getCategory()}',
      if (getDateTime() != 'Date unknown') 'Date: ${getDateTime()}',
      if (getOrganization(bundle).isNotEmpty)
        'Organization: ${getOrganization(bundle)}',
      if (getSourceAttachment().isNotEmpty) 'Source: ${getSourceAttachment()}',
      if (getNotes().isNotEmpty) 'Notes: ${getNotes()}',
    ].where((part) => part.isNotEmpty).toList();

    return parts.join(', ');
  }
}
