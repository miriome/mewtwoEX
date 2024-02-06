import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mewtwo/profile/upsert_profile/edit_profile_page/edit_profile_page_store.dart';
import 'package:mewtwo/profile/upsert_profile/widgets/upsert_profile_base/upsert_profile_base.dart';

class EditProfilePage extends ConsumerWidget {
  
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(editProfilePageStoreProvider);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Edit Profile",
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          body: UpsertProfileBase(
            store: store,
            onCtaSuccess: (context) => Navigator.of(context).pop(),
            ctaText: "Confirm",
          )),
    );
  }
}
