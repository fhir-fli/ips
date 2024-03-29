import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../ips.dart';

part 'auth_repository.g.dart';

/// Original source: Andrea Bizzotto
/// https://github.com/bizz84/complete-flutter-course
///
class AuthRepository {
  AuthRepository();

  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;

  AppUser? get currentUser => _authState.value;

  void dispose() => _authState.close();

  Future<void> signInSimple() async => _authState.value = FakeAppUser();

  Future<void> signOut() async => _authState.value = null;
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) =>
    throw UnimplementedError();

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}
