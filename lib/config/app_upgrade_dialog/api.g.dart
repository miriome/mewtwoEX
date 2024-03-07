// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getUpgradeInfoDataHash() =>
    r'87bbcbb7c9124a70291be21f21a64f135a65ef5d';

/// See also [_getUpgradeInfoData].
@ProviderFor(_getUpgradeInfoData)
final _getUpgradeInfoDataProvider = AutoDisposeFutureProvider<
    List<({bool forceUpgrade, String version})>>.internal(
  _getUpgradeInfoData,
  name: r'_getUpgradeInfoDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getUpgradeInfoDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _GetUpgradeInfoDataRef
    = AutoDisposeFutureProviderRef<List<({bool forceUpgrade, String version})>>;
String _$needUpdateHash() => r'4aa1318cbb23d508b96ac4a68fe895dc26bd9512';

/// Null means no update.
/// bool means dismissable or non dismissable update
///
/// Copied from [needUpdate].
@ProviderFor(needUpdate)
final needUpdateProvider = AutoDisposeFutureProvider<bool?>.internal(
  needUpdate,
  name: r'needUpdateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$needUpdateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NeedUpdateRef = AutoDisposeFutureProviderRef<bool?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
