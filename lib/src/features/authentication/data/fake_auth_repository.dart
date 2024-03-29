import '../../../../ips.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.addDelay = true}) {
    signInSimple();
  }

  final bool addDelay;

  final _authState = InMemoryStore<AppUser?>(null);

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;

  Future<void> signInSimple() async {
    await delay(addDelay);
    _authState.value = FakeAppUser();
  }

  @override
  AppUser? get currentUser => _authState.value;

  @override
  Future<void> signOut() async => _authState.value = null;

  @override
  void dispose() => _authState.close();
}
