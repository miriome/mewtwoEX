import 'package:flutter/material.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/unauth/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectPronounsPage extends StatelessWidget {
  const SelectPronounsPage({Key? key}) : super(key: key);

  // TODO: DB needs this to be an enum.
  static const _pronouns = ["He", "She", "Them", "Rather not say"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Padding(
            padding: EdgeInsetsDirectional.only(start: 25, top: 20),
            child: Text(
              "Login",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text(
            "What are your pronouns",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            "This information helps us enhance your experience on miromie and show you relevant content. Your personal information is well protected.",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF7D7878),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ..._pronouns.map((pronoun) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(const Color(0xFF8474A1).withOpacity(0.1))
                    ),
                    onPressed: () async {
                      final sp = await SharedPreferences.getInstance();
                      sp.setString(Constants.kKeyPronouns, pronoun);
                      if (context.mounted) {
                        SelectStyleRoute().push(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        pronoun,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    )),
              ))
        ]),
      ),
    );
  }
}
