// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_profile_base_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$upsertProfileBaseStoreHash() =>
    r'004a3144432df566331b6d3c7de3e61bcaf3874b';

/// See also [upsertProfileBaseStore].
@ProviderFor(upsertProfileBaseStore)
final upsertProfileBaseStoreProvider =
    AutoDisposeProvider<UpsertProfileBaseStore>.internal(
  upsertProfileBaseStore,
  name: r'upsertProfileBaseStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$upsertProfileBaseStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UpsertProfileBaseStoreRef
    = AutoDisposeProviderRef<UpsertProfileBaseStore>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpsertProfileBaseStore on _UpsertProfileBaseStore, Store {
  late final _$displayImagePathAtom =
      Atom(name: '_UpsertProfileBaseStore.displayImagePath', context: context);

  @override
  String get displayImagePath {
    _$displayImagePathAtom.reportRead();
    return super.displayImagePath;
  }

  @override
  set displayImagePath(String value) {
    _$displayImagePathAtom.reportWrite(value, super.displayImagePath, () {
      super.displayImagePath = value;
    });
  }

  late final _$_canSubmitAtom =
      Atom(name: '_UpsertProfileBaseStore._canSubmit', context: context);

  bool get canSubmit {
    _$_canSubmitAtom.reportRead();
    return super._canSubmit;
  }

  @override
  bool get _canSubmit => canSubmit;

  @override
  set _canSubmit(bool value) {
    _$_canSubmitAtom.reportWrite(value, super._canSubmit, () {
      super._canSubmit = value;
    });
  }

  late final _$editProfileAsyncAction =
      AsyncAction('_UpsertProfileBaseStore.editProfile', context: context);

  @override
  Future<bool> editProfile() {
    return _$editProfileAsyncAction.run(() => super.editProfile());
  }

  @override
  String toString() {
    return '''
displayImagePath: ${displayImagePath}
    ''';
  }
}
