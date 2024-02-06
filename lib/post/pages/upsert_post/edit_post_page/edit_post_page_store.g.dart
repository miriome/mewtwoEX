// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_post_page_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editPostPageStoreHash() => r'ec4ab7f365579fbc6b597d96bf0576c0cd00ec3d';

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

/// See also [editPostPageStore].
@ProviderFor(editPostPageStore)
const editPostPageStoreProvider = EditPostPageStoreFamily();

/// See also [editPostPageStore].
class EditPostPageStoreFamily extends Family<EditPostPageStore> {
  /// See also [editPostPageStore].
  const EditPostPageStoreFamily();

  /// See also [editPostPageStore].
  EditPostPageStoreProvider call({
    required int postId,
  }) {
    return EditPostPageStoreProvider(
      postId: postId,
    );
  }

  @override
  EditPostPageStoreProvider getProviderOverride(
    covariant EditPostPageStoreProvider provider,
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
  String? get name => r'editPostPageStoreProvider';
}

/// See also [editPostPageStore].
class EditPostPageStoreProvider extends AutoDisposeProvider<EditPostPageStore> {
  /// See also [editPostPageStore].
  EditPostPageStoreProvider({
    required int postId,
  }) : this._internal(
          (ref) => editPostPageStore(
            ref as EditPostPageStoreRef,
            postId: postId,
          ),
          from: editPostPageStoreProvider,
          name: r'editPostPageStoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editPostPageStoreHash,
          dependencies: EditPostPageStoreFamily._dependencies,
          allTransitiveDependencies:
              EditPostPageStoreFamily._allTransitiveDependencies,
          postId: postId,
        );

  EditPostPageStoreProvider._internal(
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
    EditPostPageStore Function(EditPostPageStoreRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditPostPageStoreProvider._internal(
        (ref) => create(ref as EditPostPageStoreRef),
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
  AutoDisposeProviderElement<EditPostPageStore> createElement() {
    return _EditPostPageStoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditPostPageStoreProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditPostPageStoreRef on AutoDisposeProviderRef<EditPostPageStore> {
  /// The parameter `postId` of this provider.
  int get postId;
}

class _EditPostPageStoreProviderElement
    extends AutoDisposeProviderElement<EditPostPageStore>
    with EditPostPageStoreRef {
  _EditPostPageStoreProviderElement(super.provider);

  @override
  int get postId => (origin as EditPostPageStoreProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditPostPageStore on AbsEditPostPageStore, Store {
  late final _$_isLoadingAtom =
      Atom(name: 'AbsEditPostPageStore._isLoading', context: context);

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$loadAsyncAction =
      AsyncAction('AbsEditPostPageStore.load', context: context);

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$postAsyncAction =
      AsyncAction('AbsEditPostPageStore.post', context: context);

  @override
  Future<bool> post() {
    return _$postAsyncAction.run(() => super.post());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
