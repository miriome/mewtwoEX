import 'dart:io';

import 'package:dartx/dartx.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/post/api/api.dart';
import 'package:mewtwo/post/pages/upsert_post/upsert_post_base/upsert_post_base_store.dart';
import 'package:mobx/mobx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_post_page_store.g.dart';

@riverpod
EditPostPageStore editPostPageStore(EditPostPageStoreRef ref, {required int postId}) {
  final store = EditPostPageStore(postId: postId);
  store.load();
  ref.onDispose(() {
    store.dispose();
  });
  return store;
}

class EditPostPageStore extends AbsEditPostPageStore with _$EditPostPageStore {
  EditPostPageStore({required int postId}) : super([], postId: postId); // Empty because pots images come from api
}

abstract class AbsEditPostPageStore extends UpsertPostBaseStore with Store {
  final int postId;
  AbsEditPostPageStore(super.editedImagePaths, {required this.postId});

  @observable
  bool _isLoading = false;

  @action
  Future<void> load() async {
    final getPostsProvider = GetPostDetailsApiProvider(postId: postId);

    final listener = Mew.pc.listen(getPostsProvider, (previous, next) {
      _isLoading = next.isLoading;
    });
    final res = await Mew.pc.read(getPostsProvider.future);
    if (res != null) {
      setPostImages(res.images.isEmpty ? [res.image] : res.images.map((e) => e.image));
      controller.text = res.caption;
    }
    listener.close();
  }


  @override
  @action
  Future<bool> post() async {
    // Only take edited images
    final photosToPost = postImagePaths
        .mapIndexed((index, imagePath) => imagePath.startsWith("http")
            ? null
            : PostPhoto(index: index, photoFileBytes: File(imagePath).readAsBytesSync()))
        .whereNotNull();

    final editPostApiProvider = EditPostApiProvider(
        postId: postId,
        caption: controller.text,
        chatEnabled: shopMyLook,
        photos: photosToPost.whereNotNull().toList());
    final res = await Mew.pc.read(editPostApiProvider.future);
    return res;
  }
}
