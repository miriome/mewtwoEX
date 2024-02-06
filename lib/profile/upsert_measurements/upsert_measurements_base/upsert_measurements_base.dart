import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/upsert_measurements_base_store.dart';

class UpsertMeasurementsBase extends StatelessWidget {
  final UpsertMeasurementsBaseStore store;
  final String ctaText;
  final void Function(BuildContext) onCtaSuccess;
  const UpsertMeasurementsBase({Key? key, required this.store, required this.ctaText, required this.onCtaSuccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: store.formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Providing miromie with your measurements will allow us to recommend you people that match your body shape, enhancing your browsing and shopping experience. By default, your measurements are visible to everyone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7D7878),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              FormBuilderTextField(
                name: 'height',
                onTapOutside: (_) {
                  store.formKey.currentState?.fields.values.forEach((element) {
                    element.effectiveFocusNode.unfocus();
                  });
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onSaved: (text) {
                  if (text != null) {
                    store.height = int.tryParse(text);
                  }
                },
                maxLength: 3,
                decoration: const InputDecoration(
                    labelText: "Height",
                    counterText: "",
                    suffixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'cm',
                          style: TextStyle(
                              color: Color(
                                0xFF7D7878,
                              ),
                              fontSize: 16),
                        ))),
              ),
              const SizedBox(
                height: 12,
              ),
              FormBuilderTextField(
                name: 'bust',
                onTapOutside: (_) {
                  store.formKey.currentState?.fields.values.forEach((element) {
                    element.effectiveFocusNode.unfocus();
                  });
                },
                keyboardType: TextInputType.number,
                maxLength: 3,
                onSaved: (text) {
                  if (text != null) {
                    store.bust = int.tryParse(text);
                  }
                },
                decoration: const InputDecoration(
                    counterText: "",
                    labelText: "Bust",
                    suffixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'in',
                          style: TextStyle(
                              color: Color(
                                0xFF7D7878,
                              ),
                              fontSize: 16),
                        ))),
              ),
              const SizedBox(
                height: 12,
              ),
              FormBuilderTextField(
                name: 'waist',
                onTapOutside: (_) {
                  store.formKey.currentState?.fields.values.forEach((element) {
                    element.effectiveFocusNode.unfocus();
                  });
                },
                maxLength: 3,
                keyboardType: TextInputType.number,
                onSaved: (text) {
                  if (text != null) {
                    store.waist = int.tryParse(text);
                  }
                },
                decoration: const InputDecoration(
                    counterText: "",
                    labelText: "Waist",
                    suffixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'in',
                          style: TextStyle(
                              color: Color(
                                0xFF7D7878,
                              ),
                              fontSize: 16),
                        ))),
              ),
              const SizedBox(
                height: 12,
              ),
              FormBuilderTextField(
                name: 'hips',
                onTapOutside: (_) {
                  store.formKey.currentState?.fields.values.forEach((element) {
                    element.effectiveFocusNode.unfocus();
                  });
                },
                maxLength: 3,
                keyboardType: TextInputType.number,
                initialValue: store.hips?.toString(),
                onSaved: (text) {
                  if (text != null) {
                    store.hips = int.tryParse(text);
                  }
                },
                decoration: const InputDecoration(
                    counterText: "",
                    labelText: "Hips",
                    suffixIcon: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'in',
                          style: TextStyle(
                              color: Color(
                                0xFF7D7878,
                              ),
                              fontSize: 16),
                        ))),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FormBuilderSwitch(
                  name: "measurementPrivacy",
                  initialValue: store.hideFromNonFollowers,
                  title: const Text(
                    "Hide my measurements from people who do not follow me",
                    style: TextStyle(fontSize: 16, color: Color(0xFF787D7D)),
                  ),
                  onSaved: (hide) {
                    store.hideFromNonFollowers = hide ?? false;
                  },
                  inactiveTrackColor: const Color(0xFF7D7878),
                  decoration:
                      const InputDecoration(enabledBorder: InputBorder.none, contentPadding: EdgeInsets.zero),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: howToMeasureYourBody(),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 40, end: 40, bottom: 24, top: 12),
                child: FilledButton(
                    onPressed: () async {
                      EasyLoading.show();
                      final success = await store.submit();
                      if (EasyLoading.isShow) {
                        EasyLoading.dismiss();
                      }
                      if (success && context.mounted) {
                        onCtaSuccess(context);
                      }
                    },
                    child: Text(
                      ctaText,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
              )
            ]),
          ),
        ),
      );
    });
  }

  Widget howToMeasureYourBody() {
    return Row(
      children: [
        const Expanded(
          child: Text.rich(
            TextSpan(style: TextStyle(color: Color(0xFF7D7878)), children: [
              TextSpan(text: "How to measure your body?\n\n", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "1. Bust\n", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: "Measure the circumference over the fullest part of your bust.\n\n",
              ),
              TextSpan(text: "2. Waist\n", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "Measure your waist at the thinnest place.\n\n"),
              TextSpan(text: "3. Hips\n", style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "Measure the fullest part of your hips."),
            ]),
            maxLines: 20,
            style: TextStyle(height: 1),
          ),
        ),
        Image.asset(
          'assets/images/measurements/measurements.webp',
          height: 192,
          width: 85,
        )
      ],
    );
  }
}
