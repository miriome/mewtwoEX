import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/unauth/api/api.dart';
import 'package:mewtwo/unauth/pages/onboarding/sign_up_page/email_validator.dart';
import 'package:mobx/mobx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_page_store.g.dart';

@riverpod
SignUpPageStore signUpPageStore(SignUpPageStoreRef ref) {
  final store = SignUpPageStore();
  ref.onDispose(() {
    store.dispose();
  });
  return store;
}

class SignUpPageStore extends _SignUpPageStore with _$SignUpPageStore {}

abstract class _SignUpPageStore with Store {
  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();

  @observable
  bool isEmailRegistered = false;

  @observable
  bool isUsernameRegistered = false;

  @observable
  String username = "";

  @observable
  String password = "";

  @observable
  String email = "";

  @observable
  bool isPasswordValidated = true;

  @observable
  bool isPasswordFieldVisible = false;

  void dispose() {
    passwordController.dispose();
  }

  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return "Username cannot be empty";
    }
    final usernameRegex = RegExp(r'''^[a-zA-Z0-9]*$''');
    if (!usernameRegex.hasMatch(username)) {
      return "This username is invalid.";
    }
    if (isUsernameRegistered) {
      return "This username has been used.";
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Email cannot be empty";
    }
    if (!EmailValidator.validate(email)) {
      return "Please enter a valid email";
    }
    if (isEmailRegistered) {
      return "This email is already registered.";
    }
    return null;
  }

  // Special validator due to displaying special widget.
  @action
  void validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      isPasswordValidated = false;
      return;
    }
    final passwordRegex =
        RegExp(r'''^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-])(?!.*[^\x00-\x7F]).{8,}$''');
    if (!passwordRegex.hasMatch(password) || password.length < 8) {
      isPasswordValidated = false;
      return;
    }
    isPasswordValidated = true;
  }

  String? validateConfirmPassword(String? confirmPassword) {
    if (passwordController.text != confirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }

  @action
  Future<void> checkIfFieldsRegistered() async {
    final usernameCheckProvider =
        CheckAccountFieldExistApiProvider(key: ExistingAccountFieldKey.username, value: username);
    final emailCheckProvider = CheckAccountFieldExistApiProvider(key: ExistingAccountFieldKey.email, value: email);
    final usernameHasDuplicate = await Mew.pc.read(usernameCheckProvider.future);
    final emailHasDuplicate = await Mew.pc.read(emailCheckProvider.future);
    if (usernameHasDuplicate != null) {
      isUsernameRegistered = usernameHasDuplicate;
    }
    if (emailHasDuplicate != null) {
      isEmailRegistered = emailHasDuplicate;
    }
  }

  @action
  Future<bool> submit() async {
    // Initial validation
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // Check duplicate
      await checkIfFieldsRegistered();
      formKey.currentState!.validate();
      if (formKey.currentState!.validate()) {
        // Call api to create account if can validate agn.
        final signuProvider = SignUpApiProvider(username: username, email: email, password: password);
        final signupSuccess = await Mew.pc.read(signuProvider.future);
        return signupSuccess;
      }
    }
    return false;
  }
}
