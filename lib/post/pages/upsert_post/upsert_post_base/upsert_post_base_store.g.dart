// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_post_base_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$upsertPostBaseStoreHash() =>
    r'716630af35a6a4ae70ad3e3b7f8c163c5256b5ec';

/// See also [upsertPostBaseStore].
@ProviderFor(upsertPostBaseStore)
final upsertPostBaseStoreProvider =
    AutoDisposeProvider<UpsertPostBaseStore>.internal(
  upsertPostBaseStore,
  name: r'upsertPostBaseStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upsertPostBaseStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpsertPostBaseStoreRef = AutoDisposeProviderRef<UpsertPostBaseStore>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpsertPostBaseStore on _UpsertPostBaseStore, Store {
  late final _$postImagePathsAtom =
      Atom(name: '_UpsertPostBaseStore.postImagePaths', context: context);

  @override
  ObservableList<String> get postImagePaths {
    _$postImagePathsAtom.reportRead();
    return super.postImagePaths;
  }

  @override
  set postImagePaths(ObservableList<String> value) {
    _$postImagePathsAtom.reportWrite(value, super.postImagePaths, () {
      super.postImagePaths = value;
    });
  }

  late final _$shopMyLookAtom =
      Atom(name: '_UpsertPostBaseStore.shopMyLook', context: context);

  @override
  bool get shopMyLook {
    _$shopMyLookAtom.reportRead();
    return super.shopMyLook;
  }

  @override
  set shopMyLook(bool value) {
    _$shopMyLookAtom.reportWrite(value, super.shopMyLook, () {
      super.shopMyLook = value;
    });
  }

  late final _$imagePagePositionAtom =
      Atom(name: '_UpsertPostBaseStore.imagePagePosition', context: context);

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

  late final _$_isImageEditingAtom =
      Atom(name: '_UpsertPostBaseStore._isImageEditing', context: context);

  bool get isImageEditing {
    _$_isImageEditingAtom.reportRead();
    return super._isImageEditing;
  }

  @override
  bool get _isImageEditing => isImageEditing;

  @override
  set _isImageEditing(bool value) {
    _$_isImageEditingAtom.reportWrite(value, super._isImageEditing, () {
      super._isImageEditing = value;
    });
  }

  late final _$postAsyncAction =
      AsyncAction('_UpsertPostBaseStore.post', context: context);

  @override
  Future<bool> post() {
    return _$postAsyncAction.run(() => super.post());
  }

  late final _$_UpsertPostBaseStoreActionController =
      ActionController(name: '_UpsertPostBaseStore', context: context);

  @override
  void removeImageAt({required int index}) {
    final _$actionInfo = _$_UpsertPostBaseStoreActionController.startAction(
        name: '_UpsertPostBaseStore.removeImageAt');
    try {
      return super.removeImageAt(index: index);
    } finally {
      _$_UpsertPostBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPostImages(Iterable<String> imagePaths) {
    final _$actionInfo = _$_UpsertPostBaseStoreActionController.startAction(
        name: '_UpsertPostBaseStore.setPostImages');
    try {
      return super.setPostImages(imagePaths);
    } finally {
      _$_UpsertPostBaseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
postImagePaths: ${postImagePaths},
shopMyLook: ${shopMyLook},
imagePagePosition: ${imagePagePosition}
    ''';
  }
}
