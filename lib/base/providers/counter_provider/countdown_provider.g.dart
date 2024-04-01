// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countdown_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$countdownNotifierHash() => r'1f79451870e126a6647b71fc01a950504b4131ca';

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

abstract class _$CountdownNotifier
    extends BuildlessAutoDisposeNotifier<Duration> {
  late final Duration initialDuration;
  late final void Function()? onDone;

  Duration build(
    Duration initialDuration, {
    void Function()? onDone,
  });
}

/// See also [CountdownNotifier].
@ProviderFor(CountdownNotifier)
const countdownNotifierProvider = CountdownNotifierFamily();

/// See also [CountdownNotifier].
class CountdownNotifierFamily extends Family<Duration> {
  /// See also [CountdownNotifier].
  const CountdownNotifierFamily();

  /// See also [CountdownNotifier].
  CountdownNotifierProvider call(
    Duration initialDuration, {
    void Function()? onDone,
  }) {
    return CountdownNotifierProvider(
      initialDuration,
      onDone: onDone,
    );
  }

  @override
  CountdownNotifierProvider getProviderOverride(
    covariant CountdownNotifierProvider provider,
  ) {
    return call(
      provider.initialDuration,
      onDone: provider.onDone,
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
  String? get name => r'countdownNotifierProvider';
}

/// See also [CountdownNotifier].
class CountdownNotifierProvider
    extends AutoDisposeNotifierProviderImpl<CountdownNotifier, Duration> {
  /// See also [CountdownNotifier].
  CountdownNotifierProvider(
    Duration initialDuration, {
    void Function()? onDone,
  }) : this._internal(
          () => CountdownNotifier()
            ..initialDuration = initialDuration
            ..onDone = onDone,
          from: countdownNotifierProvider,
          name: r'countdownNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$countdownNotifierHash,
          dependencies: CountdownNotifierFamily._dependencies,
          allTransitiveDependencies:
              CountdownNotifierFamily._allTransitiveDependencies,
          initialDuration: initialDuration,
          onDone: onDone,
        );

  CountdownNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialDuration,
    required this.onDone,
  }) : super.internal();

  final Duration initialDuration;
  final void Function()? onDone;

  @override
  Duration runNotifierBuild(
    covariant CountdownNotifier notifier,
  ) {
    return notifier.build(
      initialDuration,
      onDone: onDone,
    );
  }

  @override
  Override overrideWith(CountdownNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CountdownNotifierProvider._internal(
        () => create()
          ..initialDuration = initialDuration
          ..onDone = onDone,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialDuration: initialDuration,
        onDone: onDone,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CountdownNotifier, Duration>
      createElement() {
    return _CountdownNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CountdownNotifierProvider &&
        other.initialDuration == initialDuration &&
        other.onDone == onDone;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialDuration.hashCode);
    hash = _SystemHash.combine(hash, onDone.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CountdownNotifierRef on AutoDisposeNotifierProviderRef<Duration> {
  /// The parameter `initialDuration` of this provider.
  Duration get initialDuration;

  /// The parameter `onDone` of this provider.
  void Function()? get onDone;
}

class _CountdownNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<CountdownNotifier, Duration>
    with CountdownNotifierRef {
  _CountdownNotifierProviderElement(super.provider);

  @override
  Duration get initialDuration =>
      (origin as CountdownNotifierProvider).initialDuration;
  @override
  void Function()? get onDone => (origin as CountdownNotifierProvider).onDone;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
