// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'default':
      return _AppUser.fromJson(json);
    case 'atSign':
      return AtSignAppUser.fromJson(json);
    case 'google':
      return GoogleAppUser.fromJson(json);
    case 'local':
      return LocalAppUser.fromJson(json);
    case 'fake':
      return FakeAppUser.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'AppUser',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$AppUser {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() atSign,
    required TResult Function() google,
    required TResult Function() local,
    required TResult Function() fake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? atSign,
    TResult? Function()? google,
    TResult? Function()? local,
    TResult? Function()? fake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? atSign,
    TResult Function()? google,
    TResult Function()? local,
    TResult Function()? fake,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppUser value) $default, {
    required TResult Function(AtSignAppUser value) atSign,
    required TResult Function(GoogleAppUser value) google,
    required TResult Function(LocalAppUser value) local,
    required TResult Function(FakeAppUser value) fake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppUser value)? $default, {
    TResult? Function(AtSignAppUser value)? atSign,
    TResult? Function(GoogleAppUser value)? google,
    TResult? Function(LocalAppUser value)? local,
    TResult? Function(FakeAppUser value)? fake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppUser value)? $default, {
    TResult Function(AtSignAppUser value)? atSign,
    TResult Function(GoogleAppUser value)? google,
    TResult Function(LocalAppUser value)? local,
    TResult Function(FakeAppUser value)? fake,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
          _$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
      _$AppUserImpl _value, $Res Function(_$AppUserImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl extends _AppUser {
  const _$AppUserImpl({final String? $type})
      : $type = $type ?? 'default',
        super._();

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AppUser()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppUserImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() atSign,
    required TResult Function() google,
    required TResult Function() local,
    required TResult Function() fake,
  }) {
    return $default();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? atSign,
    TResult? Function()? google,
    TResult? Function()? local,
    TResult? Function()? fake,
  }) {
    return $default?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? atSign,
    TResult Function()? google,
    TResult Function()? local,
    TResult Function()? fake,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppUser value) $default, {
    required TResult Function(AtSignAppUser value) atSign,
    required TResult Function(GoogleAppUser value) google,
    required TResult Function(LocalAppUser value) local,
    required TResult Function(FakeAppUser value) fake,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppUser value)? $default, {
    TResult? Function(AtSignAppUser value)? atSign,
    TResult? Function(GoogleAppUser value)? google,
    TResult? Function(LocalAppUser value)? local,
    TResult? Function(FakeAppUser value)? fake,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppUser value)? $default, {
    TResult Function(AtSignAppUser value)? atSign,
    TResult Function(GoogleAppUser value)? google,
    TResult Function(LocalAppUser value)? local,
    TResult Function(FakeAppUser value)? fake,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(
      this,
    );
  }
}

abstract class _AppUser extends AppUser {
  const factory _AppUser() = _$AppUserImpl;
  const _AppUser._() : super._();

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;
}

/// @nodoc
abstract class _$$AtSignAppUserImplCopyWith<$Res> {
  factory _$$AtSignAppUserImplCopyWith(
          _$AtSignAppUserImpl value, $Res Function(_$AtSignAppUserImpl) then) =
      __$$AtSignAppUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AtSignAppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AtSignAppUserImpl>
    implements _$$AtSignAppUserImplCopyWith<$Res> {
  __$$AtSignAppUserImplCopyWithImpl(
      _$AtSignAppUserImpl _value, $Res Function(_$AtSignAppUserImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$AtSignAppUserImpl extends AtSignAppUser {
  const _$AtSignAppUserImpl({final String? $type})
      : $type = $type ?? 'atSign',
        super._();

  factory _$AtSignAppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AtSignAppUserImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AppUser.atSign()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AtSignAppUserImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() atSign,
    required TResult Function() google,
    required TResult Function() local,
    required TResult Function() fake,
  }) {
    return atSign();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? atSign,
    TResult? Function()? google,
    TResult? Function()? local,
    TResult? Function()? fake,
  }) {
    return atSign?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? atSign,
    TResult Function()? google,
    TResult Function()? local,
    TResult Function()? fake,
    required TResult orElse(),
  }) {
    if (atSign != null) {
      return atSign();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppUser value) $default, {
    required TResult Function(AtSignAppUser value) atSign,
    required TResult Function(GoogleAppUser value) google,
    required TResult Function(LocalAppUser value) local,
    required TResult Function(FakeAppUser value) fake,
  }) {
    return atSign(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppUser value)? $default, {
    TResult? Function(AtSignAppUser value)? atSign,
    TResult? Function(GoogleAppUser value)? google,
    TResult? Function(LocalAppUser value)? local,
    TResult? Function(FakeAppUser value)? fake,
  }) {
    return atSign?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppUser value)? $default, {
    TResult Function(AtSignAppUser value)? atSign,
    TResult Function(GoogleAppUser value)? google,
    TResult Function(LocalAppUser value)? local,
    TResult Function(FakeAppUser value)? fake,
    required TResult orElse(),
  }) {
    if (atSign != null) {
      return atSign(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AtSignAppUserImplToJson(
      this,
    );
  }
}

abstract class AtSignAppUser extends AppUser {
  const factory AtSignAppUser() = _$AtSignAppUserImpl;
  const AtSignAppUser._() : super._();

  factory AtSignAppUser.fromJson(Map<String, dynamic> json) =
      _$AtSignAppUserImpl.fromJson;
}

/// @nodoc
abstract class _$$GoogleAppUserImplCopyWith<$Res> {
  factory _$$GoogleAppUserImplCopyWith(
          _$GoogleAppUserImpl value, $Res Function(_$GoogleAppUserImpl) then) =
      __$$GoogleAppUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GoogleAppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$GoogleAppUserImpl>
    implements _$$GoogleAppUserImplCopyWith<$Res> {
  __$$GoogleAppUserImplCopyWithImpl(
      _$GoogleAppUserImpl _value, $Res Function(_$GoogleAppUserImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$GoogleAppUserImpl extends GoogleAppUser {
  const _$GoogleAppUserImpl({final String? $type})
      : $type = $type ?? 'google',
        super._();

  factory _$GoogleAppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$GoogleAppUserImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AppUser.google()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GoogleAppUserImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() atSign,
    required TResult Function() google,
    required TResult Function() local,
    required TResult Function() fake,
  }) {
    return google();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? atSign,
    TResult? Function()? google,
    TResult? Function()? local,
    TResult? Function()? fake,
  }) {
    return google?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? atSign,
    TResult Function()? google,
    TResult Function()? local,
    TResult Function()? fake,
    required TResult orElse(),
  }) {
    if (google != null) {
      return google();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppUser value) $default, {
    required TResult Function(AtSignAppUser value) atSign,
    required TResult Function(GoogleAppUser value) google,
    required TResult Function(LocalAppUser value) local,
    required TResult Function(FakeAppUser value) fake,
  }) {
    return google(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppUser value)? $default, {
    TResult? Function(AtSignAppUser value)? atSign,
    TResult? Function(GoogleAppUser value)? google,
    TResult? Function(LocalAppUser value)? local,
    TResult? Function(FakeAppUser value)? fake,
  }) {
    return google?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppUser value)? $default, {
    TResult Function(AtSignAppUser value)? atSign,
    TResult Function(GoogleAppUser value)? google,
    TResult Function(LocalAppUser value)? local,
    TResult Function(FakeAppUser value)? fake,
    required TResult orElse(),
  }) {
    if (google != null) {
      return google(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GoogleAppUserImplToJson(
      this,
    );
  }
}

abstract class GoogleAppUser extends AppUser {
  const factory GoogleAppUser() = _$GoogleAppUserImpl;
  const GoogleAppUser._() : super._();

  factory GoogleAppUser.fromJson(Map<String, dynamic> json) =
      _$GoogleAppUserImpl.fromJson;
}

/// @nodoc
abstract class _$$LocalAppUserImplCopyWith<$Res> {
  factory _$$LocalAppUserImplCopyWith(
          _$LocalAppUserImpl value, $Res Function(_$LocalAppUserImpl) then) =
      __$$LocalAppUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LocalAppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$LocalAppUserImpl>
    implements _$$LocalAppUserImplCopyWith<$Res> {
  __$$LocalAppUserImplCopyWithImpl(
      _$LocalAppUserImpl _value, $Res Function(_$LocalAppUserImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$LocalAppUserImpl extends LocalAppUser {
  const _$LocalAppUserImpl({final String? $type})
      : $type = $type ?? 'local',
        super._();

  factory _$LocalAppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalAppUserImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AppUser.local()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LocalAppUserImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() atSign,
    required TResult Function() google,
    required TResult Function() local,
    required TResult Function() fake,
  }) {
    return local();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? atSign,
    TResult? Function()? google,
    TResult? Function()? local,
    TResult? Function()? fake,
  }) {
    return local?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? atSign,
    TResult Function()? google,
    TResult Function()? local,
    TResult Function()? fake,
    required TResult orElse(),
  }) {
    if (local != null) {
      return local();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppUser value) $default, {
    required TResult Function(AtSignAppUser value) atSign,
    required TResult Function(GoogleAppUser value) google,
    required TResult Function(LocalAppUser value) local,
    required TResult Function(FakeAppUser value) fake,
  }) {
    return local(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppUser value)? $default, {
    TResult? Function(AtSignAppUser value)? atSign,
    TResult? Function(GoogleAppUser value)? google,
    TResult? Function(LocalAppUser value)? local,
    TResult? Function(FakeAppUser value)? fake,
  }) {
    return local?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppUser value)? $default, {
    TResult Function(AtSignAppUser value)? atSign,
    TResult Function(GoogleAppUser value)? google,
    TResult Function(LocalAppUser value)? local,
    TResult Function(FakeAppUser value)? fake,
    required TResult orElse(),
  }) {
    if (local != null) {
      return local(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalAppUserImplToJson(
      this,
    );
  }
}

abstract class LocalAppUser extends AppUser {
  const factory LocalAppUser() = _$LocalAppUserImpl;
  const LocalAppUser._() : super._();

  factory LocalAppUser.fromJson(Map<String, dynamic> json) =
      _$LocalAppUserImpl.fromJson;
}

/// @nodoc
abstract class _$$FakeAppUserImplCopyWith<$Res> {
  factory _$$FakeAppUserImplCopyWith(
          _$FakeAppUserImpl value, $Res Function(_$FakeAppUserImpl) then) =
      __$$FakeAppUserImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FakeAppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$FakeAppUserImpl>
    implements _$$FakeAppUserImplCopyWith<$Res> {
  __$$FakeAppUserImplCopyWithImpl(
      _$FakeAppUserImpl _value, $Res Function(_$FakeAppUserImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$FakeAppUserImpl extends FakeAppUser {
  const _$FakeAppUserImpl({final String? $type})
      : $type = $type ?? 'fake',
        super._();

  factory _$FakeAppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$FakeAppUserImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AppUser.fake()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$FakeAppUserImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function() $default, {
    required TResult Function() atSign,
    required TResult Function() google,
    required TResult Function() local,
    required TResult Function() fake,
  }) {
    return fake();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function()? $default, {
    TResult? Function()? atSign,
    TResult? Function()? google,
    TResult? Function()? local,
    TResult? Function()? fake,
  }) {
    return fake?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function()? $default, {
    TResult Function()? atSign,
    TResult Function()? google,
    TResult Function()? local,
    TResult Function()? fake,
    required TResult orElse(),
  }) {
    if (fake != null) {
      return fake();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AppUser value) $default, {
    required TResult Function(AtSignAppUser value) atSign,
    required TResult Function(GoogleAppUser value) google,
    required TResult Function(LocalAppUser value) local,
    required TResult Function(FakeAppUser value) fake,
  }) {
    return fake(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AppUser value)? $default, {
    TResult? Function(AtSignAppUser value)? atSign,
    TResult? Function(GoogleAppUser value)? google,
    TResult? Function(LocalAppUser value)? local,
    TResult? Function(FakeAppUser value)? fake,
  }) {
    return fake?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AppUser value)? $default, {
    TResult Function(AtSignAppUser value)? atSign,
    TResult Function(GoogleAppUser value)? google,
    TResult Function(LocalAppUser value)? local,
    TResult Function(FakeAppUser value)? fake,
    required TResult orElse(),
  }) {
    if (fake != null) {
      return fake(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FakeAppUserImplToJson(
      this,
    );
  }
}

abstract class FakeAppUser extends AppUser {
  const factory FakeAppUser() = _$FakeAppUserImpl;
  const FakeAppUser._() : super._();

  factory FakeAppUser.fromJson(Map<String, dynamic> json) =
      _$FakeAppUserImpl.fromJson;
}
