// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_page_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signUpPageStoreHash() => r'bdc6c9c5959cc8262b0f4600d8e7cb9d0ee16760';

/// See also [signUpPageStore].
@ProviderFor(signUpPageStore)
final signUpPageStoreProvider = AutoDisposeProvider<SignUpPageStore>.internal(
  signUpPageStore,
  name: r'signUpPageStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signUpPageStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SignUpPageStoreRef = AutoDisposeProviderRef<SignUpPageStore>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpPageStore on _SignUpPageStore, Store {
  late final _$isEmailRegisteredAtom =
      Atom(name: '_SignUpPageStore.isEmailRegistered', context: context);

  @override
  bool get isEmailRegistered {
    _$isEmailRegisteredAtom.reportRead();
    return super.isEmailRegistered;
  }

  @override
  set isEmailRegistered(bool value) {
    _$isEmailRegisteredAtom.reportWrite(value, super.isEmailRegistered, () {
      super.isEmailRegistered = value;
    });
  }

  late final _$isUsernameRegisteredAtom =
      Atom(name: '_SignUpPageStore.isUsernameRegistered', context: context);

  @override
  bool get isUsernameRegistered {
    _$isUsernameRegisteredAtom.reportRead();
    return super.isUsernameRegistered;
  }

  @override
  set isUsernameRegistered(bool value) {
    _$isUsernameRegisteredAtom.reportWrite(value, super.isUsernameRegistered,
        () {
      super.isUsernameRegistered = value;
    });
  }

  late final _$usernameAtom =
      Atom(name: '_SignUpPageStore.username', context: context);

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_SignUpPageStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_SignUpPageStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$isPasswordValidatedAtom =
      Atom(name: '_SignUpPageStore.isPasswordValidated', context: context);

  @override
  bool get isPasswordValidated {
    _$isPasswordValidatedAtom.reportRead();
    return super.isPasswordValidated;
  }

  @override
  set isPasswordValidated(bool value) {
    _$isPasswordValidatedAtom.reportWrite(value, super.isPasswordValidated, () {
      super.isPasswordValidated = value;
    });
  }

  late final _$isPasswordFieldVisibleAtom =
      Atom(name: '_SignUpPageStore.isPasswordFieldVisible', context: context);

  @override
  bool get isPasswordFieldVisible {
    _$isPasswordFieldVisibleAtom.reportRead();
    return super.isPasswordFieldVisible;
  }

  @override
  set isPasswordFieldVisible(bool value) {
    _$isPasswordFieldVisibleAtom
        .reportWrite(value, super.isPasswordFieldVisible, () {
      super.isPasswordFieldVisible = value;
    });
  }

  late final _$checkIfFieldsRegisteredAsyncAction =
      AsyncAction('_SignUpPageStore.checkIfFieldsRegistered', context: context);

  @override
  Future<void> checkIfFieldsRegistered() {
    return _$checkIfFieldsRegisteredAsyncAction
        .run(() => super.checkIfFieldsRegistered());
  }

  late final _$submitAsyncAction =
      AsyncAction('_SignUpPageStore.submit', context: context);

  @override
  Future<bool> submit() {
    return _$submitAsyncAction.run(() => super.submit());
  }

  late final _$_SignUpPageStoreActionController =
      ActionController(name: '_SignUpPageStore', context: context);

  @override
  void validatePassword(String? password) {
    final _$actionInfo = _$_SignUpPageStoreActionController.startAction(
        name: '_SignUpPageStore.validatePassword');
    try {
      return super.validatePassword(password);
    } finally {
      _$_SignUpPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isEmailRegistered: ${isEmailRegistered},
isUsernameRegistered: ${isUsernameRegistered},
username: ${username},
password: ${password},
email: ${email},
isPasswordValidated: ${isPasswordValidated},
isPasswordFieldVisible: ${isPasswordFieldVisible}
    ''';
  }
}
