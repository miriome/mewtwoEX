import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_nude_detector/flutter_nude_detector.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/unauth/api/api.dart';
import 'package:mobx/mobx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upsert_profile_base_store.g.dart';

@riverpod
UpsertProfileBaseStore upsertProfileBaseStore(UpsertProfileBaseStoreRef ref) {
  final store = UpsertProfileBaseStore();
  ref.onDispose(() {
    store.dispose();
  });
  return store;
}


class UpsertProfileBaseStore extends _UpsertProfileBaseStore with _$UpsertProfileBaseStore {}

abstract class _UpsertProfileBaseStore with Store {
  _UpsertProfileBaseStore() {
    nameController.addListener(() { 
      _canSubmit = nameController.text.isNotEmpty;
    });
  }
  final formKey = GlobalKey<FormBuilderState>();
  @observable
  String displayImagePath = "";

  final nameController = TextEditingController();

  @readonly
  bool _canSubmit = false;

  void dispose() {
    nameController.dispose();
  }

  @action
  Future<bool> editProfile() async {
    List<int>? fileBytes;
    if (displayImagePath.isNotEmpty && !displayImagePath.startsWith("http")) {
      final hasNudity = await FlutterNudeDetector.detect(path: displayImagePath);
      if (hasNudity) {
        Fluttertoast.showToast(msg: "Post contains improper content", gravity: ToastGravity.CENTER);
        return false;

      }
      fileBytes = File(displayImagePath).readAsBytesSync();
    }
    final editProfileProvider = EditProfileApiProvider(displayName: nameController.text, fileBytes: fileBytes);
    return await Mew.pc.read(editProfileProvider.future);
  }
}