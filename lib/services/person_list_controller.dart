import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../ips.dart';

part 'person_list_controller.g.dart';

@riverpod
class PersonListController extends _$PersonListController {
  @override
  List<IpsDataR4> build() => [];

  void set(List<IpsDataR4> value) => state = value;
}
