// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$registerPushTokenApiHash() =>
    r'50657ed788fb00706663ffab29e5a6b89176335b';

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

/// See also [registerPushTokenApi].
@ProviderFor(registerPushTokenApi)
const registerPushTokenApiProvider = RegisterPushTokenApiFamily();

/// See also [registerPushTokenApi].
class RegisterPushTokenApiFamily extends Family<AsyncValue<void>> {
  /// See also [registerPushTokenApi].
  const RegisterPushTokenApiFamily();

  /// See also [registerPushTokenApi].
  RegisterPushTokenApiProvider call({
    required String value,
  }) {
    return RegisterPushTokenApiProvider(
      value: value,
    );
  }

  @override
  RegisterPushTokenApiProvider getProviderOverride(
    covariant RegisterPushTokenApiProvider provider,
  ) {
    return call(
      value: provider.value,
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
  String? get name => r'registerPushTokenApiProvider';
}

/// See also [registerPushTokenApi].
class RegisterPushTokenApiProvider extends AutoDisposeFutureProvider<void> {
  /// See also [registerPushTokenApi].
  RegisterPushTokenApiProvider({
    required String value,
  }) : this._internal(
          (ref) => registerPushTokenApi(
            ref as RegisterPushTokenApiRef,
            value: value,
          ),
          from: registerPushTokenApiProvider,
          name: r'registerPushTokenApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$registerPushTokenApiHash,
          dependencies: RegisterPushTokenApiFamily._dependencies,
          allTransitiveDependencies:
              RegisterPushTokenApiFamily._allTransitiveDependencies,
          value: value,
        );

  RegisterPushTokenApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.value,
  }) : super.internal();

  final String value;

  @override
  Override overrideWith(
    FutureOr<void> Function(RegisterPushTokenApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegisterPushTokenApiProvider._internal(
        (ref) => create(ref as RegisterPushTokenApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        value: value,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _RegisterPushTokenApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterPushTokenApiProvider && other.value == value;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RegisterPushTokenApiRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `value` of this provider.
  String get value;
}

class _RegisterPushTokenApiProviderElement
    extends AutoDisposeFutureProviderElement<void>
    with RegisterPushTokenApiRef {
  _RegisterPushTokenApiProviderElement(super.provider);

  @override
  String get value => (origin as RegisterPushTokenApiProvider).value;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
