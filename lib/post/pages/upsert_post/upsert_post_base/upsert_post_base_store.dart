import 'dart:io';
import 'dart:typed_data';

import 'package:dartx/dartx.dart';
import 'package:detectable_text_field/widgets/detectable_text_editing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nude_detector/flutter_nude_detector.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/post/api/api.dart';
import 'package:mewtwo/post/pages/upsert_post/images_summary_edit_page/images_summary_edit_page_store.dart';
import 'package:mewtwo/post/widgets/user_mention_search/user_mention_search_store.dart';
import 'package:mewtwo/profile/profile_page/profile_page_store.dart';
import 'package:mobx/mobx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upsert_post_base_store.g.dart';

@riverpod
UpsertPostBaseStore upsertPostBaseStore(UpsertPostBaseStoreRef ref) {
  final imageSummaryEditStore = ref.read(imageSummaryEditPageStoreProvider);
  final store = UpsertPostBaseStore(imageSummaryEditStore.displayImagePaths);
  ref.onDispose(() {
    store.dispose();
  });
  return store;
}

class UpsertPostBaseStore extends _UpsertPostBaseStore with _$UpsertPostBaseStore {
  UpsertPostBaseStore(super.editedImagePaths);
}

abstract class _UpsertPostBaseStore with Store {
  final controller = DetectableTextEditingController();

  final userMentionStore = UserMentionSearchStore();

  _UpsertPostBaseStore(List<String> editedImagePaths) {
    postImagePaths = ObservableList.of(editedImagePaths);
  }

  void addListenerForPortalController(OverlayPortalController portalController) {
    controller.addListener(() {
      if (userMentionStore.userResults.isEmpty) {
        portalController.hide();
      }
      final cursorBasePosition = controller.selection.baseOffset;
      if (cursorBasePosition == -1) {
        // base position becomes -1 when changing text.
        return;
      }

      if (cursorBasePosition != controller.selection.extentOffset) {
        // Is cursor selection, ignore
        return;
      }
      final splitString = controller.selection.textBefore(controller.text).split(" ");
      if (splitString.isEmpty) {
        return;
      }
      String currentlyEditingText = splitString.last;
      // Only @, need user to give filter, so dont show.
      if (!currentlyEditingText.startsWith("@") || (currentlyEditingText.length < 2)) {
        portalController.hide();
        return;
      }
      userMentionStore.search(currentlyEditingText.substring(1));
      if (userMentionStore.isLoading) {
        portalController.show();
      }
    });
  }

  @observable
  ObservableList<String> postImagePaths = ObservableList.of([]);

  @observable
  bool shopMyLook = false;

  @observable
  double imagePagePosition = 0;

  @readonly
  bool _isImageEditing = false;

  @action
  void removeImageAt({required int index}) {
    postImagePaths.removeAt(index);
  }

  @action
  void setPostImages(Iterable<String> imagePaths) {
    postImagePaths = ObservableList.of(imagePaths);
  }

  void dispose() {
    controller.dispose();
  }

  void onMentionUserSearchTap(UserModel user) {
    final cursorBasePosition = controller.selection.baseOffset;

    if (cursorBasePosition != controller.selection.extentOffset) {
      // Is cursor selection, ignore
      return;
    }
    final splitString = controller.selection.textBefore(controller.text).split(" ");
    if (splitString.isEmpty) {
      return;
    }
    splitString[splitString.length - 1] = "@${user.username} ";
    final mentionedString = splitString.join(" ");
    controller.text = mentionedString + controller.text.substring(controller.selection.baseOffset);
  }

  @action
  Future<bool> post() async {
    final imagesIndexThatHaveNudity = (await Future.wait(postImagePaths.mapIndexed((index, image) async {
      final path = image;
      if (!path.startsWith("http")) {
        final hasNudity = await FlutterNudeDetector.detect(path: path);
        return hasNudity ? index + 1 : null;
      }
      return null;
    })))
        .whereNotNull();

    if (imagesIndexThatHaveNudity.isNotEmpty) {
      Fluttertoast.showToast(
          msg: "Images ${imagesIndexThatHaveNudity.joinToString(separator: ", ")} are inappropriate");
      return false;
    }
    final photosToPost = postImagePaths
        .mapIndexed((index, path) => PostPhoto(index: index, photoFileBytes: File(path).readAsBytesSync()));

    final upsertPostProvider =
        AddPostApiProvider(caption: controller.text, chatEnabled: shopMyLook, photos: photosToPost.toList());
    final res = await Mew.pc.read(upsertPostProvider.future);
    if (res) {
      Future.delayed(const Duration(milliseconds: 250), () {
        Mew.pc.read(currentUserProfilePageStoreProvider).load();
      });
    }
    return res;
  }
}
