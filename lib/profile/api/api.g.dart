// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editStylesApiHash() => r'07012e271e0ca7e6d852687467fdb8441e8d626d';

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

/// See also [editStylesApi].
@ProviderFor(editStylesApi)
const editStylesApiProvider = EditStylesApiFamily();

/// See also [editStylesApi].
class EditStylesApiFamily extends Family<AsyncValue<bool>> {
  /// See also [editStylesApi].
  const EditStylesApiFamily();

  /// See also [editStylesApi].
  EditStylesApiProvider call({
    required Set<String> styles,
  }) {
    return EditStylesApiProvider(
      styles: styles,
    );
  }

  @override
  EditStylesApiProvider getProviderOverride(
    covariant EditStylesApiProvider provider,
  ) {
    return call(
      styles: provider.styles,
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
  String? get name => r'editStylesApiProvider';
}

/// See also [editStylesApi].
class EditStylesApiProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [editStylesApi].
  EditStylesApiProvider({
    required Set<String> styles,
  }) : this._internal(
          (ref) => editStylesApi(
            ref as EditStylesApiRef,
            styles: styles,
          ),
          from: editStylesApiProvider,
          name: r'editStylesApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editStylesApiHash,
          dependencies: EditStylesApiFamily._dependencies,
          allTransitiveDependencies:
              EditStylesApiFamily._allTransitiveDependencies,
          styles: styles,
        );

  EditStylesApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.styles,
  }) : super.internal();

  final Set<String> styles;

  @override
  Override overrideWith(
    FutureOr<bool> Function(EditStylesApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditStylesApiProvider._internal(
        (ref) => create(ref as EditStylesApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        styles: styles,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _EditStylesApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditStylesApiProvider && other.styles == styles;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, styles.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditStylesApiRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `styles` of this provider.
  Set<String> get styles;
}

class _EditStylesApiProviderElement
    extends AutoDisposeFutureProviderElement<bool> with EditStylesApiRef {
  _EditStylesApiProviderElement(super.provider);

  @override
  Set<String> get styles => (origin as EditStylesApiProvider).styles;
}

String _$deleteAccountApiHash() => r'ebbdbb60d08dd19057b91becc899ab97dec237c3';

/// See also [deleteAccountApi].
@ProviderFor(deleteAccountApi)
final deleteAccountApiProvider = AutoDisposeFutureProvider<bool>.internal(
  deleteAccountApi,
  name: r'deleteAccountApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteAccountApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeleteAccountApiRef = AutoDisposeFutureProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
