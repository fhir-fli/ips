import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'use_widgetbook.g.dart';

@Riverpod(keepAlive: true)
bool shouldUseWidgetbook(ShouldUseWidgetbookRef ref) {
  return false;
}
