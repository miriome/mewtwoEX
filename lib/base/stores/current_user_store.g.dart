// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserStoreHash() => r'7d4a9ad20174bad4e3c87556bf85c398b3facb5b';

/// See also [currentUserStore].
@ProviderFor(currentUserStore)
final currentUserStoreProvider = Provider<CurrentUserStore>.internal(
  currentUserStore,
  name: r'currentUserStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserStoreRef = ProviderRef<CurrentUserStore>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CurrentUserStore on _CurrentUserStore, Store {
  late final _$_userAtom =
      Atom(name: '_CurrentUserStore._user', context: context);

  UserModel? get user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  UserModel? get _user => user;

  @override
  set _user(UserModel? value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  late final _$loadAsyncAction =
      AsyncAction('_CurrentUserStore.load', context: context);

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
