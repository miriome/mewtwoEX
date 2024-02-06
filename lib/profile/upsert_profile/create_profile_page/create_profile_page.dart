import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mewtwo/profile/routes/routes.dart';
import 'package:mewtwo/profile/upsert_profile/widgets/upsert_profile_base/upsert_profile_base.dart';
import 'package:mewtwo/profile/upsert_profile/widgets/upsert_profile_base/upsert_profile_base_store.dart';
import 'package:mewtwo/routes/routes.dart';


class CreateProfilePage extends ConsumerWidget {
  final ImagePicker picker = ImagePicker();
  
  
  CreateProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(upsertProfileBaseStoreProvider);
    return PopScope(
      canPop: false,
      child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      CreateMeasurementsRoute().push(context);
                    },
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Color(0xFF7D7878)),
                    )),
              ],
              title: const Text(
                "Mirror me",
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
              ),
              automaticallyImplyLeading: false,
            ),
            body: UpsertProfileBase(store: store, onCtaSuccess: (context) => CreateMeasurementsRoute().push(context), ctaText: "Next",)
          ),
        )
    );
  }
}
