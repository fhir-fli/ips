import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

const double _logoOpacity = 0.2;
const double _buttonBorderRadius = 30.0;
const TextStyle _loginTextStyle = TextStyle(fontSize: 36);
const EdgeInsets _screenPadding = EdgeInsets.all(8.0);

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: _screenPadding,
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Center(
              child: screenSize.width > Breakpoint.tablet
                  ? const LargeScreenLogin()
                  : const SmallScreenLogin(),
            ),
          ),
        ),
      ),
    );
  }
}

class LargeScreenLogin extends StatelessWidget {
  const LargeScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 1,
          child: Opacity(
            opacity: _logoOpacity,
            child: Image.asset('assets/images/ips-logo.png', fit: BoxFit.cover),
          ),
        ),
        Flexible(
          flex: 2,
          child: _LoginColumn(screenSize: screenSize),
        ),
      ],
    );
  }
}

class SmallScreenLogin extends StatelessWidget {
  const SmallScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: _LoginColumn(screenSize: screenSize),
    );
  }
}

class _LoginColumn extends StatelessWidget {
  final Size screenSize;

  const _LoginColumn({required this.screenSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLoginHeader(),
        SizedBox(height: screenSize.height * 0.05),
        _LoginTextField(hint: 'Username'),
        SizedBox(height: screenSize.height * 0.05),
        _LoginTextField(hint: 'Password'),
        const LocalLoginButton(),
        const Text('© 2024 The Children’s Hospital of Philadelphia'),
        // Placeholder for atSign login method
        TextButton(
          onPressed: () {},
          child: const Text('Login with @sign'),
        ),
      ],
    );
  }

  Widget _buildLoginHeader() => Center(
        child: Text(
          'Login',
          style: _loginTextStyle,
        ),
      );
}

class _LoginTextField extends StatelessWidget {
  final String hint;

  const _LoginTextField({required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.1),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_buttonBorderRadius),
          ),
        ),
      ),
    );
  }
}

class LocalLoginButton extends StatelessWidget {
  const LocalLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return IconButton(
      onPressed: () {
        // Navigate or perform local authentication
      },
      icon: Image.asset(
        'assets/images/fingerprint${isDarkMode ? '-dark' : '-light'}.png',
        width: screenSize.width * 0.25,
      ),
      tooltip: 'Local Login',
    );
  }
}
