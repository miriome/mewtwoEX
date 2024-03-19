// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDropPostDetailsApiHash() =>
    r'b4951e3e0177059e3b3284fcfcfdd977000508bf';

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
