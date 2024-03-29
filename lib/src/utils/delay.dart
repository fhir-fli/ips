/// Original source: Andrea Bizzotto
/// https://github.com/bizz84/complete-flutter-course
///
/// a small helper function to return a Future with a configurable delay
Future<void> delay(bool addDelay, [int milliseconds = 300]) {
  if (addDelay) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  } else {
    return Future.value();
  }
}
