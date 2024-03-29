import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ips_screen_controller.g.dart';

@riverpod
class IpsPeopleListController extends _$IpsPeopleListController
    with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // no-op
  }

  Future<void> loadPeople() async {
    state = const AsyncLoading();

    // final clientAssetsRepository = ref.read(clientAssetsRepositoryProvider);

    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signInSimple(),
    );
  }
}
