import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser() = _AppUser;
  const factory AppUser.atSign() = AtSignAppUser;
  const factory AppUser.google() = GoogleAppUser;
  const factory AppUser.local() = LocalAppUser;
  const factory AppUser.fake() = FakeAppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
