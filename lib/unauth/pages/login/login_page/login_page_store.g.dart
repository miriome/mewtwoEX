// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginPageStore on _LoginPageStore, Store {
  late final _$_usernameControllerAtom =
      Atom(name: '_LoginPageStore._usernameController', context: context);

  TextEditingController get usernameController {
    _$_usernameControllerAtom.reportRead();
    return super._usernameController;
  }

  @override
  TextEditingController get _usernameController => usernameController;

  @override
  set _usernameController(TextEditingController value) {
    _$_usernameControllerAtom.reportWrite(value, super._usernameController, () {
      super._usernameController = value;
    });
  }

  late final _$_passwordControllerAtom =
      Atom(name: '_LoginPageStore._passwordController', context: context);

  TextEditingController get passwordController {
    _$_passwordControllerAtom.reportRead();
    return super._passwordController;
  }

  @override
  TextEditingController get _passwordController => passwordController;

  @override
  set _passwordController(TextEditingController value) {
    _$_passwordControllerAtom.reportWrite(value, super._passwordController, () {
      super._passwordController = value;
    });
  }

  late final _$isPasswordHiddenAtom =
      Atom(name: '_LoginPageStore.isPasswordHidden', context: context);

  @override
  bool get isPasswordHidden {
    _$isPasswordHiddenAtom.reportRead();
    return super.isPasswordHidden;
  }

  @override
  set isPasswordHidden(bool value) {
    _$isPasswordHiddenAtom.reportWrite(value, super.isPasswordHidden, () {
      super.isPasswordHidden = value;
    });
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginPageStore.login', context: context);

  @override
  Future<bool> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  @override
  String toString() {
    return '''
isPasswordHidden: ${isPasswordHidden}
    ''';
  }
}
