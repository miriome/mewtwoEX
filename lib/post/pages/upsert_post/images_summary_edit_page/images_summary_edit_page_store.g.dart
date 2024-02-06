// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images_summary_edit_page_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$imageSummaryEditPageStoreHash() =>
    r'0ccfec3a363e9980b93f4e29330ce295917cce67';

/// See also [imageSummaryEditPageStore].
@ProviderFor(imageSummaryEditPageStore)
final imageSummaryEditPageStoreProvider =
    AutoDisposeProvider<ImageSummaryEditPageStore>.internal(
  imageSummaryEditPageStore,
  name: r'imageSummaryEditPageStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imageSummaryEditPageStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ImageSummaryEditPageStoreRef
    = AutoDisposeProviderRef<ImageSummaryEditPageStore>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ImageSummaryEditPageStore on _ImageSummaryEditPageStore, Store {
  Computed<List<String>>? _$displayImagePathsComputed;

  @override
  List<String> get displayImagePaths => (_$displayImagePathsComputed ??=
          Computed<List<String>>(() => super.displayImagePaths,
              name: '_ImageSummaryEditPageStore.displayImagePaths'))
      .value;
  Computed<List<int>>? _$uneditedImageNumbersComputed;

  @override
  List<int> get uneditedImageNumbers => (_$uneditedImageNumbersComputed ??=
          Computed<List<int>>(() => super.uneditedImageNumbers,
              name: '_ImageSummaryEditPageStore.uneditedImageNumbers'))
      .value;

  late final _$imagePagePositionAtom = Atom(
      name: '_ImageSummaryEditPageStore.imagePagePosition', context: context);

  @override
  double get imagePagePosition {
    _$imagePagePositionAtom.reportRead();
    return super.imagePagePosition;
  }

  @override
  set imagePagePosition(double value) {
    _$imagePagePositionAtom.reportWrite(value, super.imagePagePosition, () {
      super.imagePagePosition = value;
    });
  }

  late final _$_postImagesAtom =
      Atom(name: '_ImageSummaryEditPageStore._postImages', context: context);

  @override
  ObservableList<_PostImage> get _postImages {
    _$_postImagesAtom.reportRead();
    return super._postImages;
  }

  @override
  set _postImages(ObservableList<_PostImage> value) {
    _$_postImagesAtom.reportWrite(value, super._postImages, () {
      super._postImages = value;
    });
  }

  late final _$cropAllImagesAsyncAction =
      AsyncAction('_ImageSummaryEditPageStore.cropAllImages', context: context);

  @override
  Future<void> cropAllImages(
      GlobalKey<State<StatefulWidget>> postImageGlobalKey) {
    return _$cropAllImagesAsyncAction
        .run(() => super.cropAllImages(postImageGlobalKey));
  }

  late final _$_ImageSummaryEditPageStoreActionController =
      ActionController(name: '_ImageSummaryEditPageStore', context: context);

  @override
  void updatePagePosition(double page) {
    final _$actionInfo = _$_ImageSummaryEditPageStoreActionController
        .startAction(name: '_ImageSummaryEditPageStore.updatePagePosition');
    try {
      return super.updatePagePosition(page);
    } finally {
      _$_ImageSummaryEditPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addSelectedImages(Iterable<String> paths, bool isEditPost) {
    final _$actionInfo = _$_ImageSummaryEditPageStoreActionController
        .startAction(name: '_ImageSummaryEditPageStore.addSelectedImages');
    try {
      return super.addSelectedImages(paths, isEditPost);
    } finally {
      _$_ImageSummaryEditPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSelectedImages(Iterable<String> paths, bool isEditPost) {
    final _$actionInfo = _$_ImageSummaryEditPageStoreActionController
        .startAction(name: '_ImageSummaryEditPageStore.setSelectedImages');
    try {
      return super.setSelectedImages(paths, isEditPost);
    } finally {
      _$_ImageSummaryEditPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAllImages() {
    final _$actionInfo = _$_ImageSummaryEditPageStoreActionController
        .startAction(name: '_ImageSummaryEditPageStore.clearAllImages');
    try {
      return super.clearAllImages();
    } finally {
      _$_ImageSummaryEditPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeImageAt({required int index}) {
    final _$actionInfo = _$_ImageSummaryEditPageStoreActionController
        .startAction(name: '_ImageSummaryEditPageStore.removeImageAt');
    try {
      return super.removeImageAt(index: index);
    } finally {
      _$_ImageSummaryEditPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateImagePathAt({required int index, required String path}) {
    final _$actionInfo = _$_ImageSummaryEditPageStoreActionController
        .startAction(name: '_ImageSummaryEditPageStore.updateImagePathAt');
    try {
      return super.updateImagePathAt(index: index, path: path);
    } finally {
      _$_ImageSummaryEditPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
imagePagePosition: ${imagePagePosition},
displayImagePaths: ${displayImagePaths},
uneditedImageNumbers: ${uneditedImageNumbers}
    ''';
  }
}
