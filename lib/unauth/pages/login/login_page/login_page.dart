import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mewtwo/config/app_upgrade_dialog/app_upgrade_dialog.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/unauth/pages/login/login_page/login_page_store.dart';
import 'package:mewtwo/base/pages/webview/webview.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mewtwo/unauth/routes/routes.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final store = LoginPageStore();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      AppUpgradeDialog.showIfNeeded(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: Container(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 92,
                      ),
                      header(),
                      const SizedBox(
                        height: 52,
                      ),
                      usernameInput(),
                      const SizedBox(height: 20),
                      passwordInput(),
                      forgetPassword(),
                      const SizedBox(
                        height: 32,
                      ),
                      signInButton(),
                      const SizedBox(
                        height: 32,
                      ),
                      startHere(),
                      const Spacer(),
                      privacyPolicy(),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                )),
          ),
        );
      }
    );
  }

  Widget header() {
    return Text(
      "miromie",
      style: GoogleFonts.barlow(
          textStyle: const TextStyle(
              fontSize: 70,
              color: Color(
                0xFF6EC6CA,
              ),
              fontWeight: FontWeight.w700)),
    );
  }

  Widget usernameInput() {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Username",
            style: TextStyle(color: Color(0xFF7D7878)),
          ),
          TextFormField(
            controller: store.usernameController,
            maxLines: 1,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              isCollapsed: true,
              enabledBorder: InputBorder.none,
              border: InputBorder.none, isDense: true),
          )
        ],
      ),
    );
  }

  Widget passwordInput() {
    return Container(
      padding: const EdgeInsetsDirectional.only(top: 8, bottom: 8, start: 20, end: 8),
      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Password",
                  style: TextStyle(color: Color(0xFF7D7878)),
                ),
                TextFormField(
                  obscureText: store.isPasswordHidden,
                  controller: store.passwordController,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    isCollapsed: true,
                    border: InputBorder.none, isDense: true),
                )
              ],
            ),
          ),
          IconButton(onPressed: () {
            store.isPasswordHidden = !store.isPasswordHidden;
          }, icon: Icon(store.isPasswordHidden ? Icons.visibility : Icons.visibility_off, color: const Color(0xFF7D7878),))
        ],
      ),
    );
  }

  Widget forgetPassword() {
    return Builder(
      builder: (context) {
        return Row(
          children: [
            const Spacer(),
            TextButton(
                onPressed: () {
                  ForgetPasswordRoute().push(context);
                  
                },
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(color: Color(0xFF7D7878), decoration: TextDecoration.underline),
                ))
          ],
        );
      }
    );
  }

  Widget signInButton() {
    return Builder(
      builder: (context) {
        return FilledButton(
          onPressed: () async {
            EasyLoading.show();
            final loginSuccess = await store.login();
            EasyLoading.dismiss();
            if (loginSuccess && context.mounted) {
              HomePageRoute().go(context);
            }
          },
          child: SizedBox(
            width: 122,
            height: 44,
            child: Center(
              child: Text(
                "Sign in",
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget startHere() {
    return Builder(
      builder: (context) {
        return TextButton(
            onPressed: () {
              SelectPronounsRoute().push(context);
            },
            child: const Text.rich(TextSpan(children: [
              TextSpan(text: "Don't have an account? "),
              TextSpan(
                  text: "Start here!", style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w700))
            ], style: TextStyle(color: Colors.black, fontSize: 12))));
      }
    );
  }

  Widget privacyPolicy() {
    return Builder(
      builder: (context) {
        return Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: "By continuing, you agree to miromie's "),
              WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Webview(url: "https://miromie.wordpress.com/termsofuse/", title: "Terms of use",)));
                    },
                    child: const Text("Terms of use", style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w700),),
                  )
              ),
              const TextSpan(text: " and confirm that you have read and understood our "),
              WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Webview(url: "https://miromie.wordpress.com/privacypolicy/", title: "Privacy Policy",)));
                    },
                    child: const Text("Privacy Policy",style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w700),),
                  )
              ),
              const TextSpan(text: " and that you are at least 13 years old."),
            ],
          ),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFF7D7878), fontSize: 12),
        );
      }
    );
  }
}
