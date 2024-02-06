// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reportContentApiHash() => r'eaed67bd671795f9c0561e139b27dabaaea74b68';

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

/// See also [reportContentApi].
@ProviderFor(reportContentApi)
const reportContentApiProvider = ReportContentApiFamily();

/// See also [reportContentApi].
class ReportContentApiFamily extends Family<AsyncValue<bool>> {
  /// See also [reportContentApi].
  const ReportContentApiFamily();

  /// See also [reportContentApi].
  ReportContentApiProvider call({
    required ReportType reportType,
    required String typeId,
    required String reason,
  }) {
    return ReportContentApiProvider(
      reportType: reportType,
      typeId: typeId,
      reason: reason,
    );
  }

  @override
  ReportContentApiProvider getProviderOverride(
    covariant ReportContentApiProvider provider,
  ) {
    return call(
      reportType: provider.reportType,
      typeId: provider.typeId,
      reason: provider.reason,
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
  String? get name => r'reportContentApiProvider';
}

/// See also [reportContentApi].
class ReportContentApiProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [reportContentApi].
  ReportContentApiProvider({
    required ReportType reportType,
    required String typeId,
    required String reason,
  }) : this._internal(
          (ref) => reportContentApi(
            ref as ReportContentApiRef,
            reportType: reportType,
            typeId: typeId,
            reason: reason,
          ),
          from: reportContentApiProvider,
          name: r'reportContentApiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reportContentApiHash,
          dependencies: ReportContentApiFamily._dependencies,
          allTransitiveDependencies:
              ReportContentApiFamily._allTransitiveDependencies,
          reportType: reportType,
          typeId: typeId,
          reason: reason,
        );

  ReportContentApiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.reportType,
    required this.typeId,
    required this.reason,
  }) : super.internal();

  final ReportType reportType;
  final String typeId;
  final String reason;

  @override
  Override overrideWith(
    FutureOr<bool> Function(ReportContentApiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReportContentApiProvider._internal(
        (ref) => create(ref as ReportContentApiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        reportType: reportType,
        typeId: typeId,
        reason: reason,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _ReportContentApiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportContentApiProvider &&
        other.reportType == reportType &&
        other.typeId == typeId &&
        other.reason == reason;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reportType.hashCode);
    hash = _SystemHash.combine(hash, typeId.hashCode);
    hash = _SystemHash.combine(hash, reason.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ReportContentApiRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `reportType` of this provider.
  ReportType get reportType;

  /// The parameter `typeId` of this provider.
  String get typeId;

  /// The parameter `reason` of this provider.
  String get reason;
}

class _ReportContentApiProviderElement
    extends AutoDisposeFutureProviderElement<bool> with ReportContentApiRef {
  _ReportContentApiProviderElement(super.provider);

  @override
  ReportType get reportType => (origin as ReportContentApiProvider).reportType;
  @override
  String get typeId => (origin as ReportContentApiProvider).typeId;
  @override
  String get reason => (origin as ReportContentApiProvider).reason;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
