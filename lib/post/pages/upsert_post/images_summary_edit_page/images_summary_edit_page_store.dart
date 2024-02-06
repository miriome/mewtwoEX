import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:mewtwo/base/widgets/post_image.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as img;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'images_summary_edit_page_store.g.dart';

class _PostImage {
  String path;
  bool isEdited;
  _PostImage({required this.path, required this.isEdited});
}

@riverpod
ImageSummaryEditPageStore imageSummaryEditPageStore(ImageSummaryEditPageStoreRef ref) {
  final store = ImageSummaryEditPageStore();
  ref.onDispose(() {
    store.dispose();
  });
  return store;
}

class ImageSummaryEditPageStore extends _ImageSummaryEditPageStore with _$ImageSummaryEditPageStore {}

abstract class _ImageSummaryEditPageStore with Store {
  void dispose() {}

  @observable
  double imagePagePosition = 0;

  @action
  void updatePagePosition(double page) {
    imagePagePosition = page;
  }

  @observable
  ObservableList<_PostImage> _postImages = ObservableList.of([]);

  @computed
  List<String> get displayImagePaths => _postImages.map((image) => image.path).toList();

  // Index + 1 of unedited images
  @computed
  List<int> get uneditedImageNumbers =>
      _postImages.mapIndexed((index, image) => image.isEdited ? null : index + 1).whereNotNull().toList();

  @action
  void addSelectedImages(Iterable<String> paths, bool isEditPost) {
    // All photos from edit post have already been edited
    _postImages.addAll(paths.map((path) => _PostImage(path: path, isEdited: isEditPost)));
  }

  @action
  void setSelectedImages(Iterable<String> paths, bool isEditPost) {
    // All photos from edit post have already been edited
    _postImages = ObservableList.of(paths.map((path) => _PostImage(path: path, isEdited: isEditPost)));
  }

  @action
  void clearAllImages() {
    _postImages.clear();
  }

  @action
  void removeImageAt({required int index}) {
    _postImages.removeAt(index);
    // After removing from last index, the current page position will be same as the length.
    if (index == _postImages.length) {
      imagePagePosition = imagePagePosition - 1;
    }
  }

  @action
  void updateImagePathAt({required int index, required String path}) {
    _postImages.removeAt(index);
    _postImages.insert(index, _PostImage(isEdited: true, path: path));
  }

  @action
  Future<void> cropAllImages(GlobalKey postImageGlobalKey) async {
    final editedImagesFuture = _postImages.map((postImage) async {
      if (postImage.isEdited) {
        return _PostImage(path: postImage.path, isEdited: true);
      }
      final editedImagePath = await _processImageFile(File(postImage.path), postImageGlobalKey);
      if (editedImagePath != null) {
        return _PostImage(path: editedImagePath, isEdited: true);
      }
      // Not manually cropped or auto cropped
      return _PostImage(path: postImage.path, isEdited: false);
    });
    final editedImages = await Future.wait(editedImagesFuture);
    _postImages = ObservableList.of(editedImages);
  }

  // Crops image from rectangle in view.
  Future<String?> _processImageFile(File file, GlobalKey postImageGlobalKey) async {
    final imageBytes = file.readAsBytesSync();
    final decodedImage = await decodeImageFromList(imageBytes);

    RenderBox? box = postImageGlobalKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) {
      return null;
    }

    final imageSize = Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());
    final FittedSizes sizes = applyBoxFit(PostImage.fit, imageSize, box.size);
    final imageRect = Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
    final cmd = img.Command()
      // Decode the image file at the given path
      ..decodeImage(imageBytes)
      ..copyCrop(
          x: imageRect.left.toInt(),
          y: imageRect.top.toInt(),
          width: imageRect.width.toInt() * 5,
          height: imageRect.height.toInt() * 5);

    await cmd.executeThread();
    if (cmd.outputImage == null) {
      return null;
    }
    final output = img.encodeNamedImage(file.path, cmd.outputImage!);
    if (output == null) {
      return null;
    }

    final tempDir = await getTemporaryDirectory();
    final editedFile =
        File(p.join(tempDir.path, "${md5.convert(utf8.encode(file.path)).toString()}.${p.extension(file.path)}"))
          ..writeAsBytesSync(output);
    return editedFile.path;
  }
}
