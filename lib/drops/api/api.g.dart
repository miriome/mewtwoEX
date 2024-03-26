// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getNextDropHash() => r'f14a92444acede737d89ddc7aeac923540b886a2';

/// See also [getNextDrop].
@ProviderFor(getNextDrop)
final getNextDropProvider = AutoDisposeFutureProvider<
    ({DateTime end, int id, DateTime start})>.internal(
  getNextDrop,
  name: r'getNextDropProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getNextDropHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetNextDropRef
    = AutoDisposeFutureProviderRef<({DateTime end, int id, DateTime start})>;
String _$getDropsListHash() => r'2440c4edac8b61a81e9b7262518f0e8c5dadaddb';

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

/// See also [getDropsList].
@ProviderFor(getDropsList)
const getDropsListProvider = GetDropsListFamily();

/// See also [getDropsList].
class GetDropsListFamily extends Family<AsyncValue<List<DropPostModel>>> {
  /// See also [getDropsList].
  const GetDropsListFamily();

  /// See also [getDropsList].
  GetDropsListProvider call(
    int dropId,
  ) {
    return GetDropsListProvider(
      dropId,
    );
  }

  @override
  GetDropsListProvider getProviderOverride(
    covariant GetDropsListProvider provider,
  ) {
    return call(
      provider.dropId,
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
  String? get name => r'getDropsListProvider';
}

/// See also [getDropsList].
class GetDropsListProvider
    extends AutoDisposeFutureProvider<List<DropPostModel>> {
  /// See also [getDropsList].
  GetDropsListProvider(
    int dropId,
  ) : this._internal(
          (ref) => getDropsList(
            ref as GetDropsListRef,
            dropId,
          ),
          from: getDropsListProvider,
          name: r'getDropsListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDropsListHash,
          dependencies: GetDropsListFamily._dependencies,
          allTransitiveDependencies:
              GetDropsListFamily._allTransitiveDependencies,
          dropId: dropId,
        );

  GetDropsListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dropId,
  }) : super.internal();

  final int dropId;

  @override
  Override overrideWith(
    FutureOr<List<DropPostModel>> Function(GetDropsListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDropsListProvider._internal(
        (ref) => create(ref as GetDropsListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dropId: dropId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DropPostModel>> createElement() {
    return _GetDropsListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDropsListProvider && other.dropId == dropId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dropId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDropsListRef on AutoDisposeFutureProviderRef<List<DropPostModel>> {
  /// The parameter `dropId` of this provider.
  int get dropId;
}

class _GetDropsListProviderElement
    extends AutoDisposeFutureProviderElement<List<DropPostModel>>
    with GetDropsListRef {
  _GetDropsListProviderElement(super.provider);

  @override
  int get dropId => (origin as GetDropsListProvider).dropId;
}

String _$getDropPostDetailsApiHash() =>
    r'b4951e3e0177059e3b3284fcfcfdd977000508bf';

/// See also [getDropPostDetailsApi].
@ProviderFor(getDropPostDetailsApi)
const getDropPostDetailsApiProvider = GetDropPostDetailsApiFamily();

/// See also [getDropPostDetailsApi].
class GetDropPostDetailsApiFamily extends Family<AsyncValue<DropPostModel?>> {
  /// See also [getDropPostDetailsApi].
  const GetDropPostDetailsApiFamily();

  /// See also [getDropPostDetailsApi].
  GetDropPostDetailsApiProvider call({
    required int postId,
  }) {
    return GetDropPostDetailsApiProvider(
      postId: postId,
    );
  }

  @override
  GetDropPostDetailsApiProvider getProviderOverride(
    covariant GetDropPostDetailsApiProvider provider,
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
  String? get name => r'getDropPostDetailsApiProvider';
}

/// See also [getDropPostDetailsApi].
class GetDropPostDetailsApiProvider
    extends AutoDisposeFutureProvider<DropPostModel?> {
  /// See also [getDropPostDetailsApi].
  GetDropPostDetailsApiProvider({
    required int postId,
  }) : this._internal(
          (ref) => getDropPostDetailsApi(
            ref as GetDropPostDetailsApiRef,
            postId: postId,
          ),
          from: getDropPostDetailsApiProvider,
          name: r'getDropPostDetailsApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDropPostDetailsApiHash,
          dependencies: GetDropPostDetailsApiFamily._dependencies,
          allTransitiveDependencies:
              GetDropPostDetailsApiFamily._allTransitiveDependencies,
          postId: postId,
        );

  GetDropPostDetailsApiProvider._internal(
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
    FutureOr<DropPostModel?> Function(GetDropPostDetailsApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDropPostDetailsApiProvider._internal(
        (ref) => create(ref as GetDropPostDetailsApiRef),
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
  AutoDisposeFutureProviderElement<DropPostModel?> createElement() {
    return _GetDropPostDetailsApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDropPostDetailsApiProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDropPostDetailsApiRef on AutoDisposeFutureProviderRef<DropPostModel?> {
  /// The parameter `postId` of this provider.
  int get postId;
}

class _GetDropPostDetailsApiProviderElement
    extends AutoDisposeFutureProviderElement<DropPostModel?>
    with GetDropPostDetailsApiRef {
  _GetDropPostDetailsApiProviderElement(super.provider);

  @override
  int get postId => (origin as GetDropPostDetailsApiProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
