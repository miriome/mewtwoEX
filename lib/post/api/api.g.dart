// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLikedPostsApiHash() => r'485898c23a4354c9e26c9ab9e34cc4b8ac9bdb84';

/// See also [getLikedPostsApi].
@ProviderFor(getLikedPostsApi)
final getLikedPostsApiProvider =
    AutoDisposeFutureProvider<List<PostModel>>.internal(
  getLikedPostsApi,
  name: r'getLikedPostsApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLikedPostsApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLikedPostsApiRef = AutoDisposeFutureProviderRef<List<PostModel>>;
String _$getPostDetailsApiHash() => r'582cfe39ac44dd477f66519bab8e32740fae57f4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getPostDetailsApi].
@ProviderFor(getPostDetailsApi)
const getPostDetailsApiProvider = GetPostDetailsApiFamily();

/// See also [getPostDetailsApi].
class GetPostDetailsApiFamily extends Family<AsyncValue<PostModel?>> {
  /// See also [getPostDetailsApi].
  const GetPostDetailsApiFamily();

  /// See also [getPostDetailsApi].
  GetPostDetailsApiProvider call({
    required int postId,
  }) {
    return GetPostDetailsApiProvider(
      postId: postId,
    );
  }

  @override
  GetPostDetailsApiProvider getProviderOverride(
    covariant GetPostDetailsApiProvider provider,
  ) {
    return call(
      postId: provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getPostDetailsApiProvider';
}

/// See also [getPostDetailsApi].
class GetPostDetailsApiProvider extends AutoDisposeFutureProvider<PostModel?> {
  /// See also [getPostDetailsApi].
  GetPostDetailsApiProvider({
    required int postId,
  }) : this._internal(
          (ref) => getPostDetailsApi(
            ref as GetPostDetailsApiRef,
            postId: postId,
          ),
          from: getPostDetailsApiProvider,
          name: r'getPostDetailsApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPostDetailsApiHash,
          dependencies: GetPostDetailsApiFamily._dependencies,
          allTransitiveDependencies:
              GetPostDetailsApiFamily._allTransitiveDependencies,
          postId: postId,
        );

  GetPostDetailsApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final int postId;

  @override
  Override overrideWith(
    FutureOr<PostModel?> Function(GetPostDetailsApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPostDetailsApiProvider._internal(
        (ref) => create(ref as GetPostDetailsApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PostModel?> createElement() {
    return _GetPostDetailsApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPostDetailsApiProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPostDetailsApiRef on AutoDisposeFutureProviderRef<PostModel?> {
  /// The parameter `postId` of this provider.
  int get postId;
}

class _GetPostDetailsApiProviderElement
    extends AutoDisposeFutureProviderElement<PostModel?>
    with GetPostDetailsApiRef {
  _GetPostDetailsApiProviderElement(super.provider);

  @override
  int get postId => (origin as GetPostDetailsApiProvider).postId;
}

String _$deleteCommentApiHash() => r'b751d96d823b3bb35f52da5ad011ebee9cc37b3f';

/// See also [deleteCommentApi].
@ProviderFor(deleteCommentApi)
const deleteCommentApiProvider = DeleteCommentApiFamily();

/// See also [deleteCommentApi].
class DeleteCommentApiFamily extends Family<AsyncValue<bool>> {
  /// See also [deleteCommentApi].
  const DeleteCommentApiFamily();

  /// See also [deleteCommentApi].
  DeleteCommentApiProvider call({
    required int commentId,
  }) {
    return DeleteCommentApiProvider(
      commentId: commentId,
    );
  }

  @override
  DeleteCommentApiProvider getProviderOverride(
    covariant DeleteCommentApiProvider provider,
  ) {
    return call(
      commentId: provider.commentId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deleteCommentApiProvider';
}

/// See also [deleteCommentApi].
class DeleteCommentApiProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deleteCommentApi].
  DeleteCommentApiProvider({
    required int commentId,
  }) : this._internal(
          (ref) => deleteCommentApi(
            ref as DeleteCommentApiRef,
            commentId: commentId,
          ),
          from: deleteCommentApiProvider,
          name: r'deleteCommentApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteCommentApiHash,
          dependencies: DeleteCommentApiFamily._dependencies,
          allTransitiveDependencies:
              DeleteCommentApiFamily._allTransitiveDependencies,
          commentId: commentId,
        );

  DeleteCommentApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.commentId,
  }) : super.internal();

  final int commentId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeleteCommentApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeleteCommentApiProvider._internal(
        (ref) => create(ref as DeleteCommentApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        commentId: commentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeleteCommentApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeleteCommentApiProvider && other.commentId == commentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, commentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeleteCommentApiRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `commentId` of this provider.
  int get commentId;
}

class _DeleteCommentApiProviderElement
    extends AutoDisposeFutureProviderElement<bool> with DeleteCommentApiRef {
  _DeleteCommentApiProviderElement(super.provider);

  @override
  int get commentId => (origin as DeleteCommentApiProvider).commentId;
}

String _$addCommentApiHash() => r'39f08c1d78cbcf5da28b17304e20fc83c49b7960';

/// See also [addCommentApi].
@ProviderFor(addCommentApi)
const addCommentApiProvider = AddCommentApiFamily();

/// See also [addCommentApi].
class AddCommentApiFamily extends Family<AsyncValue<bool>> {
  /// See also [addCommentApi].
  const AddCommentApiFamily();

  /// See also [addCommentApi].
  AddCommentApiProvider call({
    required int postId,
    required String comment,
  }) {
    return AddCommentApiProvider(
      postId: postId,
      comment: comment,
    );
  }

  @override
  AddCommentApiProvider getProviderOverride(
    covariant AddCommentApiProvider provider,
  ) {
    return call(
      postId: provider.postId,
      comment: provider.comment,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'addCommentApiProvider';
}

/// See also [addCommentApi].
class AddCommentApiProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addCommentApi].
  AddCommentApiProvider({
    required int postId,
    required String comment,
  }) : this._internal(
          (ref) => addCommentApi(
            ref as AddCommentApiRef,
            postId: postId,
            comment: comment,
          ),
          from: addCommentApiProvider,
          name: r'addCommentApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addCommentApiHash,
          dependencies: AddCommentApiFamily._dependencies,
          allTransitiveDependencies:
              AddCommentApiFamily._allTransitiveDependencies,
          postId: postId,
          comment: comment,
        );

  AddCommentApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
    required this.comment,
  }) : super.internal();

  final int postId;
  final String comment;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddCommentApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddCommentApiProvider._internal(
        (ref) => create(ref as AddCommentApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
        comment: comment,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddCommentApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddCommentApiProvider &&
        other.postId == postId &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);
    hash = _SystemHash.combine(hash, comment.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddCommentApiRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `postId` of this provider.
  int get postId;

  /// The parameter `comment` of this provider.
  String get comment;
}

class _AddCommentApiProviderElement
    extends AutoDisposeFutureProviderElement<bool> with AddCommentApiRef {
  _AddCommentApiProviderElement(super.provider);

  @override
  int get postId => (origin as AddCommentApiProvider).postId;
  @override
  String get comment => (origin as AddCommentApiProvider).comment;
}

String _$deletePostApiHash() => r'9bc1aa142f74f8396e8c94dd59276e8ee6c39831';

/// See also [deletePostApi].
@ProviderFor(deletePostApi)
const deletePostApiProvider = DeletePostApiFamily();

/// See also [deletePostApi].
class DeletePostApiFamily extends Family<AsyncValue<bool>> {
  /// See also [deletePostApi].
  const DeletePostApiFamily();

  /// See also [deletePostApi].
  DeletePostApiProvider call({
    required int postId,
  }) {
    return DeletePostApiProvider(
      postId: postId,
    );
  }

  @override
  DeletePostApiProvider getProviderOverride(
    covariant DeletePostApiProvider provider,
  ) {
    return call(
      postId: provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deletePostApiProvider';
}

/// See also [deletePostApi].
class DeletePostApiProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [deletePostApi].
  DeletePostApiProvider({
    required int postId,
  }) : this._internal(
          (ref) => deletePostApi(
            ref as DeletePostApiRef,
            postId: postId,
          ),
          from: deletePostApiProvider,
          name: r'deletePostApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deletePostApiHash,
          dependencies: DeletePostApiFamily._dependencies,
          allTransitiveDependencies:
              DeletePostApiFamily._allTransitiveDependencies,
          postId: postId,
        );

  DeletePostApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final int postId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(DeletePostApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeletePostApiProvider._internal(
        (ref) => create(ref as DeletePostApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _DeletePostApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeletePostApiProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeletePostApiRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `postId` of this provider.
  int get postId;
}

class _DeletePostApiProviderElement
    extends AutoDisposeFutureProviderElement<bool> with DeletePostApiRef {
  _DeletePostApiProviderElement(super.provider);

  @override
  int get postId => (origin as DeletePostApiProvider).postId;
}

String _$markPostSoldApiHash() => r'4a29a1095d094e13ef1e5d37bf7d977027a26e27';

/// See also [markPostSoldApi].
@ProviderFor(markPostSoldApi)
const markPostSoldApiProvider = MarkPostSoldApiFamily();

/// See also [markPostSoldApi].
class MarkPostSoldApiFamily extends Family<AsyncValue<bool>> {
  /// See also [markPostSoldApi].
  const MarkPostSoldApiFamily();

  /// See also [markPostSoldApi].
  MarkPostSoldApiProvider call({
    required int postId,
  }) {
    return MarkPostSoldApiProvider(
      postId: postId,
    );
  }

  @override
  MarkPostSoldApiProvider getProviderOverride(
    covariant MarkPostSoldApiProvider provider,
  ) {
    return call(
      postId: provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'markPostSoldApiProvider';
}

/// See also [markPostSoldApi].
class MarkPostSoldApiProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [markPostSoldApi].
  MarkPostSoldApiProvider({
    required int postId,
  }) : this._internal(
          (ref) => markPostSoldApi(
            ref as MarkPostSoldApiRef,
            postId: postId,
          ),
          from: markPostSoldApiProvider,
          name: r'markPostSoldApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$markPostSoldApiHash,
          dependencies: MarkPostSoldApiFamily._dependencies,
          allTransitiveDependencies:
              MarkPostSoldApiFamily._allTransitiveDependencies,
          postId: postId,
        );

  MarkPostSoldApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final int postId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(MarkPostSoldApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MarkPostSoldApiProvider._internal(
        (ref) => create(ref as MarkPostSoldApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _MarkPostSoldApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MarkPostSoldApiProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MarkPostSoldApiRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `postId` of this provider.
  int get postId;
}

class _MarkPostSoldApiProviderElement
    extends AutoDisposeFutureProviderElement<bool> with MarkPostSoldApiRef {
  _MarkPostSoldApiProviderElement(super.provider);

  @override
  int get postId => (origin as MarkPostSoldApiProvider).postId;
}

String _$editPostApiHash() => r'b1628ed661c048d655139643ddc4418a62c361cd';

/// See also [editPostApi].
@ProviderFor(editPostApi)
const editPostApiProvider = EditPostApiFamily();

/// See also [editPostApi].
class EditPostApiFamily extends Family<AsyncValue<bool>> {
  /// See also [editPostApi].
  const EditPostApiFamily();

  /// See also [editPostApi].
  EditPostApiProvider call({
    required int postId,
    required String caption,
    required bool chatEnabled,
    required List<PostPhoto> photos,
  }) {
    return EditPostApiProvider(
      postId: postId,
      caption: caption,
      chatEnabled: chatEnabled,
      photos: photos,
    );
  }

  @override
  EditPostApiProvider getProviderOverride(
    covariant EditPostApiProvider provider,
  ) {
    return call(
      postId: provider.postId,
      caption: provider.caption,
      chatEnabled: provider.chatEnabled,
      photos: provider.photos,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editPostApiProvider';
}

/// See also [editPostApi].
class EditPostApiProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [editPostApi].
  EditPostApiProvider({
    required int postId,
    required String caption,
    required bool chatEnabled,
    required List<PostPhoto> photos,
  }) : this._internal(
          (ref) => editPostApi(
            ref as EditPostApiRef,
            postId: postId,
            caption: caption,
            chatEnabled: chatEnabled,
            photos: photos,
          ),
          from: editPostApiProvider,
          name: r'editPostApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editPostApiHash,
          dependencies: EditPostApiFamily._dependencies,
          allTransitiveDependencies:
              EditPostApiFamily._allTransitiveDependencies,
          postId: postId,
          caption: caption,
          chatEnabled: chatEnabled,
          photos: photos,
        );

  EditPostApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
    required this.caption,
    required this.chatEnabled,
    required this.photos,
  }) : super.internal();

  final int postId;
  final String caption;
  final bool chatEnabled;
  final List<PostPhoto> photos;

  @override
  Override overrideWith(
    FutureOr<bool> Function(EditPostApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditPostApiProvider._internal(
        (ref) => create(ref as EditPostApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
        caption: caption,
        chatEnabled: chatEnabled,
        photos: photos,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _EditPostApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditPostApiProvider &&
        other.postId == postId &&
        other.caption == caption &&
        other.chatEnabled == chatEnabled &&
        other.photos == photos;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);
    hash = _SystemHash.combine(hash, caption.hashCode);
    hash = _SystemHash.combine(hash, chatEnabled.hashCode);
    hash = _SystemHash.combine(hash, photos.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditPostApiRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `postId` of this provider.
  int get postId;

  /// The parameter `caption` of this provider.
  String get caption;

  /// The parameter `chatEnabled` of this provider.
  bool get chatEnabled;

  /// The parameter `photos` of this provider.
  List<PostPhoto> get photos;
}

class _EditPostApiProviderElement extends AutoDisposeFutureProviderElement<bool>
    with EditPostApiRef {
  _EditPostApiProviderElement(super.provider);

  @override
  int get postId => (origin as EditPostApiProvider).postId;
  @override
  String get caption => (origin as EditPostApiProvider).caption;
  @override
  bool get chatEnabled => (origin as EditPostApiProvider).chatEnabled;
  @override
  List<PostPhoto> get photos => (origin as EditPostApiProvider).photos;
}

String _$addPostApiHash() => r'5cb512c473eb15a85810ecca65c46d6bc659cdff';

/// See also [addPostApi].
@ProviderFor(addPostApi)
const addPostApiProvider = AddPostApiFamily();

/// See also [addPostApi].
class AddPostApiFamily extends Family<AsyncValue<bool>> {
  /// See also [addPostApi].
  const AddPostApiFamily();

  /// See also [addPostApi].
  AddPostApiProvider call({
    required String caption,
    required bool chatEnabled,
    required List<PostPhoto> photos,
  }) {
    return AddPostApiProvider(
      caption: caption,
      chatEnabled: chatEnabled,
      photos: photos,
    );
  }

  @override
  AddPostApiProvider getProviderOverride(
    covariant AddPostApiProvider provider,
  ) {
    return call(
      caption: provider.caption,
      chatEnabled: provider.chatEnabled,
      photos: provider.photos,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'addPostApiProvider';
}

/// See also [addPostApi].
class AddPostApiProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [addPostApi].
  AddPostApiProvider({
    required String caption,
    required bool chatEnabled,
    required List<PostPhoto> photos,
  }) : this._internal(
          (ref) => addPostApi(
            ref as AddPostApiRef,
            caption: caption,
            chatEnabled: chatEnabled,
            photos: photos,
          ),
          from: addPostApiProvider,
          name: r'addPostApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addPostApiHash,
          dependencies: AddPostApiFamily._dependencies,
          allTransitiveDependencies:
              AddPostApiFamily._allTransitiveDependencies,
          caption: caption,
          chatEnabled: chatEnabled,
          photos: photos,
        );

  AddPostApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.caption,
    required this.chatEnabled,
    required this.photos,
  }) : super.internal();

  final String caption;
  final bool chatEnabled;
  final List<PostPhoto> photos;

  @override
  Override overrideWith(
    FutureOr<bool> Function(AddPostApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddPostApiProvider._internal(
        (ref) => create(ref as AddPostApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        caption: caption,
        chatEnabled: chatEnabled,
        photos: photos,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _AddPostApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddPostApiProvider &&
        other.caption == caption &&
        other.chatEnabled == chatEnabled &&
        other.photos == photos;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, caption.hashCode);
    hash = _SystemHash.combine(hash, chatEnabled.hashCode);
    hash = _SystemHash.combine(hash, photos.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AddPostApiRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `caption` of this provider.
  String get caption;

  /// The parameter `chatEnabled` of this provider.
  bool get chatEnabled;

  /// The parameter `photos` of this provider.
  List<PostPhoto> get photos;
}

class _AddPostApiProviderElement extends AutoDisposeFutureProviderElement<bool>
    with AddPostApiRef {
  _AddPostApiProviderElement(super.provider);

  @override
  String get caption => (origin as AddPostApiProvider).caption;
  @override
  bool get chatEnabled => (origin as AddPostApiProvider).chatEnabled;
  @override
  List<PostPhoto> get photos => (origin as AddPostApiProvider).photos;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
