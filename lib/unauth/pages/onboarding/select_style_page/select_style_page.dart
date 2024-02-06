import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/routes/routes.dart';
import 'package:mewtwo/unauth/pages/onboarding/select_style_page/select_style_page_store.dart';
import 'package:mewtwo/unauth/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectStylePage extends StatelessWidget {
  SelectStylePage({Key? key}) : super(key: key);
  final store = SelectStylePageStore();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                  onTap: () {
                    SignUpRoute().push(context);
                  },
                  child: const Text("Skip", style: TextStyle(fontSize: 12, color: Color(0xFF7D7878)))),
              const SizedBox(
                width: 28,
              )
            ],
          ),
          body: buildBody()),
    );
  }

  Widget buildBody() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Which of these styles do you like?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 44,
            ),
            Expanded(child: stylesGrid),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FilledButton(
                style: const ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                onPressed: () async {
                  await onCtaTap(context);
                },
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<void> onCtaTap(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(Constants.kKeyStyles, store.selectedStyles.join(","));
    if (context.mounted) {
      SignUpRoute().push(context);
    }
  }

  Widget get stylesGrid {
    return GridView.builder(
      itemCount: Constants.kStyles.length,
      itemBuilder: (context, index) {
        final style = Constants.kStyles[index];
        return GestureDetector(
          onTap: () {
            if (store.selectedStyles.contains(style)) {
              store.selectedStyles.remove(style);
              return;
            }
            store.selectedStyles.add(style);
          },
          child: Column(
            children: [
              Expanded(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(6),
                  child: ClipRRect(
                    borderRadius: const BorderRadiusDirectional.all(Radius.circular(6)),
                    child: Column(
                      children: [
                        Observer(builder: (context) {
                          return AspectRatio(
                            aspectRatio: 100 / 135,
                            child: Image.asset(
                              'assets/images/styles/$style.jpg',
                              fit: BoxFit.cover,
                              cacheWidth: 135,
                              color: store.selectedStyles.contains(style)
                                  ? Theme.of(context).primaryColor.withOpacity(0.5)
                                  : null,
                              colorBlendMode: BlendMode.srcOver,
                            ),
                          );
                        }),
                        Text(
                          style,
                          style: const TextStyle(fontSize: 16, color: Color(0xFF7D7878)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8,) // Required because gridview does not properly show elevation
            ],
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, mainAxisSpacing: 24, crossAxisSpacing: 24, childAspectRatio: 100 / 166),
    );
  }
}
