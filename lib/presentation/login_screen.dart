import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Widget _iconButton(String path, String label) => IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PersonScreen()),
          ),
          icon: Column(
            children: [
              SizedBox(
                  width: (screenSize.width > screenSize.height
                          ? screenSize.height
                          : screenSize.width) *
                      0.3,
                  child: Image(image: AssetImage(path))),
            ],
          ),
        );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
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
          ),
        ),
      ),
    );
  }
}
