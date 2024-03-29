import 'package:collection/collection.dart';
import 'package:fhir_r4/fhir_r4.dart';

extension ConsentAdvanceDirectiveR4 on Consent {
  String getStatus() => status?.value ?? "Unknown";

  String getCategory() =>
      category.firstOrNull?.coding?.firstOrNull?.display ?? '--';

  String getDateTime() => dateTime?.value.toIso8601String() ?? 'Date unknown';

  String getOrganization(Bundle bundle) {
    if (organization != null && organization!.isNotEmpty) {
      final reference = organization!.first.reference ?? '';
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
      sourceAttachment?.title ?? sourceReference?.display ?? '--';

  String getNotes() => text?.div ?? '--';
}
