import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ips/ips.dart';

/// This is the root widget of the login flow, which has 2 pages:
/// 1. Login page (e.g. @atsign, local, google/apple)
/// 2. Loading page

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const _Login());
  }
}

class _Login extends ConsumerWidget {
  const _Login();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      loginScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final screenSize = MediaQuery.of(context).size;
    final state = ref.watch(loginScreenControllerProvider);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Widget _iconButton(String path, String label) => IconButton(
          onPressed: () {},
          icon: Column(
            children: [
              // Text(label),
              SizedBox(
                  width: screenSize.width * 0.3,
                  child: Image(image: AssetImage(path))),
            ],
          ),
        );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      opacity: AlwaysStoppedAnimation(.2),
                      image: AssetImage('assets/images/ips-logo.png'),
                    ),
                    SizedBox(height: screenSize.height * 0.08),
                    Center(
                        child: Text(
                      'Login'.hardcoded,
                      style: TextStyle(fontSize: 36),
                    )),
                    SizedBox(height: screenSize.height * 0.08),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _iconButton(
                            'assets/images/fingerprint${isDarkMode ? '-dark' : '-light'}.png',
                            'Local Login'.hardcoded),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
