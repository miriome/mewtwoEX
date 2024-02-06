import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mewtwo/base/widgets/miromie_title.dart';
import 'package:mewtwo/profile/routes/routes.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/unauth/pages/onboarding/sign_up_page/invalid_password_criteria_dialog.dart';
import 'package:mewtwo/unauth/pages/onboarding/sign_up_page/sign_up_page_store.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(signUpPageStoreProvider);
    return Observer(builder: (context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: store.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: MiromieTitle(fontSize: 70)),
                  const SizedBox(
                    height: 56,
                  ),
                  TextFormField(
                    onTap: () => store.isUsernameRegistered = false, // Reset validation
                    maxLines: 1,
                    style: const TextStyle(fontSize: 16),
                    onSaved: (text) {
                      store.username = text ?? "";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: textFieldDecoration(context: context, labelText: "Username"),
                    validator: (text) {
                      return store.validateUsername(text);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    maxLines: 1,
                    onTap: () => store.isEmailRegistered = false, // Reset validation
                    onSaved: (text) {
                      store.email = text ?? "";
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (text) {
                      return store.validateEmail(text);
                    },
                    style: const TextStyle(fontSize: 16),
                    decoration: textFieldDecoration(context: context, labelText: "Email"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    maxLines: 1,
                    onTap: () => store.isPasswordValidated = true, // Reset validation
                    controller: store.passwordController,
                    style: const TextStyle(fontSize: 16),
                    onSaved: (text) {
                      store.password = text ?? "";
                    },
                    validator: (text) {
                      store.validatePassword(text);
                      return null;
                    },
                    obscureText: !store.isPasswordFieldVisible,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: textFieldDecoration(context: context, labelText: "Password").copyWith(
                        suffixIcon: IconButton(
                            onPressed: () {
                              store.isPasswordFieldVisible = !store.isPasswordFieldVisible;
                            },
                            icon: Icon(
                              store.isPasswordFieldVisible ? Icons.visibility : Icons.visibility_off,
                              size: 28,
                              color: const Color(0xFF7D7878),
                            )),
                        error: !store.isPasswordValidated
                            ? Text.rich(TextSpan(children: [
                                const TextSpan(text: "This password does not meet our "),
                                TextSpan(
                                    text: "criteria.",
                                    style: TextStyle(
                                        inherit: true,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.w700,
                                        decorationColor: Theme.of(context).colorScheme.error),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        InvalidPasswordCriteriaDialog.show(context);
                                      })
                              ], style: TextStyle(color: Theme.of(context).colorScheme.error)))
                            : null),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                      maxLines: 1,
                      style: const TextStyle(fontSize: 16),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: !store.isPasswordFieldVisible,
                      validator: (text) {
                        return store.validateConfirmPassword(text);
                      },
                      decoration: textFieldDecoration(context: context, labelText: "Confirm Password").copyWith()),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: FilledButton(
                        onPressed: () async {
                          EasyLoading.show();
                          final success = await store.submit();
                          if (EasyLoading.isShow) {
                            EasyLoading.dismiss();
                          }
                          if (success && context.mounted) {
                            CreateProfileRoute().push(context);
                          }
                        },
                        child: const Text("Sign up", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700))),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  InputDecoration textFieldDecoration({required BuildContext context, required String labelText}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return TextStyle(color: Theme.of(context).disabledColor);
        }
        if (states.contains(MaterialState.error)) {
          return TextStyle(color: Theme.of(context).colorScheme.error);
        }
        if (states.contains(MaterialState.focused)) {
          return TextStyle(color: Theme.of(context).colorScheme.primary);
        }
        return const TextStyle(color: Color(0xFF8474A1));
      }),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF8474A1)), borderRadius: BorderRadius.circular(12)),
    );
  }
}
