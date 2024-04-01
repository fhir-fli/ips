import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ips.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Center(
                child: screenSize.width > Breakpoint.tablet
                    ? LargeScreenLogin()
                    : SmallScreenLogin()),
          ),
        ),
      ),
    );
  }
}

class LargeScreenLogin extends StatelessWidget {
  const LargeScreenLogin();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sizedBox = SizedBox(height: screenSize.height * 0.05);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: screenSize.height * 0.3,
          height: screenSize.height * 0.3,
          child: Image.asset(
            'assets/images/ips-logo.png',
            opacity: AlwaysStoppedAnimation(.2),
            fit: BoxFit.cover,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              'Login'.hardcoded,
              style: TextStyle(fontSize: 36),
            )),
            sizedBox,
            SizedBox(
              width: screenSize.width * 0.4,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username'.hardcoded,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            sizedBox,
            SizedBox(
              width: screenSize.width * 0.4,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password'.hardcoded,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            LocalLoginButton(),
          ],
        ),
      ],
    );
  }
}

class SmallScreenLogin extends StatelessWidget {
  const SmallScreenLogin();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sizedBox = SizedBox(height: screenSize.height * 0.05);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            opacity: AlwaysStoppedAnimation(.2),
            image: AssetImage('assets/images/ips-logo.png'),
          ),
          Center(
              child: Text(
            'Login'.hardcoded,
            style: TextStyle(fontSize: 36),
          )),
          sizedBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Username'.hardcoded,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          sizedBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Password'.hardcoded,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          LocalLoginButton(),
        ],
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
                  0.25,
              child: Column(
                children: [
                  Image(
                      image: AssetImage(
                          'assets/images/fingerprint${isDarkMode ? '-dark' : '-light'}.png')),
                  Text('Local Login'.hardcoded)
                ],
              )),
        ],
      ),
    );
  }
}
