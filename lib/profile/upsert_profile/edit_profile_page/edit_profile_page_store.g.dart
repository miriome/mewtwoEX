// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile_page_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editProfilePageStoreHash() =>
    r'4f93153b0a72b0c8a1daea54dda6b9662b4a9f67';

/// See also [editProfilePageStore].
@ProviderFor(editProfilePageStore)
final editProfilePageStoreProvider =
    AutoDisposeProvider<EditProfilePageStore>.internal(
  editProfilePageStore,
  name: r'editProfilePageStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$editProfilePageStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef EditProfilePageStoreRef = AutoDisposeProviderRef<EditProfilePageStore>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditProfilePageStore on AbsProfilePageStore, Store {
  late final _$loadAsyncAction =
      AsyncAction('AbsProfilePageStore.load', context: context);

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
