import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../src.dart';

part 'app_routing.g.dart';

enum AppRoute {
  ips,
  login,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref
    ..onDispose(isAuth.dispose) // don't forget to clean after yourselves (:
    // update the listenable, when some provider value changes
    // here, we are just interested in whether the user's logged in
    ..listen(
      authStateChangesProvider
          .select((value) => value.whenData((value) => value != null)),
      (_, next) {
        isAuth.value = next;
      },
    );
  final useWidgetbook = ref.read(shouldUseWidgetbookProvider);
  final initialLocation = useWidgetbook ? '/widgetbook' : '/login';

  final router = GoRouter(
    initialLocation: initialLocation,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    requestFocus: false,
    // * redirect logic based on the authentication state
    // redirect: (context, state) async {
    //   if (useWidgetbook) {
    //     /// no data connected, no workflows displayed
    //     /// ignore all redirects
    //     return '/widgetbook';
    //   }
    //   final authRepository = ref.read(authRepositoryProvider);
    //   final user = authRepository.currentUser;
    //   // final isLoggedIn = user != null && await user.client.isLoggedIn();
    //   // final path = state.uri.path;

    //   return '/sign-in';
    //   // TODO(FireJuun): redirect logic here...
    //   // if not logged in and trying to go somewhere they shouldn't
    // },
    refreshListenable: isAuth,
    routes: [
      GoRoute(
        path: '/login',
        name: AppRoute.login.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/ips',
        name: AppRoute.ips.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: IpsScreen(),
        ),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );

  ref.onDispose(router.dispose);

  return router;
}
