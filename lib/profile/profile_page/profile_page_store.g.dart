// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_page_store.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$otherUserProfilePageStoreHash() =>
    r'e350aeb0c00ea564524e5f64fe38c15b37794558';

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

/// See also [otherUserProfilePageStore].
@ProviderFor(otherUserProfilePageStore)
const otherUserProfilePageStoreProvider = OtherUserProfilePageStoreFamily();

/// See also [otherUserProfilePageStore].
class OtherUserProfilePageStoreFamily extends Family<ProfilePageStore> {
  /// See also [otherUserProfilePageStore].
  const OtherUserProfilePageStoreFamily();

  /// See also [otherUserProfilePageStore].
  OtherUserProfilePageStoreProvider call({
    required int userId,
  }) {
    return OtherUserProfilePageStoreProvider(
      userId: userId,
    );
  }

  @override
  OtherUserProfilePageStoreProvider getProviderOverride(
    covariant OtherUserProfilePageStoreProvider provider,
  ) {
    return call(
      userId: provider.userId,
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
  String? get name => r'otherUserProfilePageStoreProvider';
}

/// See also [otherUserProfilePageStore].
class OtherUserProfilePageStoreProvider
    extends AutoDisposeProvider<ProfilePageStore> {
  /// See also [otherUserProfilePageStore].
  OtherUserProfilePageStoreProvider({
    required int userId,
  }) : this._internal(
          (ref) => otherUserProfilePageStore(
            ref as OtherUserProfilePageStoreRef,
            userId: userId,
          ),
          from: otherUserProfilePageStoreProvider,
          name: r'otherUserProfilePageStoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$otherUserProfilePageStoreHash,
          dependencies: OtherUserProfilePageStoreFamily._dependencies,
          allTransitiveDependencies:
              OtherUserProfilePageStoreFamily._allTransitiveDependencies,
          userId: userId,
        );

  OtherUserProfilePageStoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final int userId;

  @override
  Override overrideWith(
    ProfilePageStore Function(OtherUserProfilePageStoreRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OtherUserProfilePageStoreProvider._internal(
        (ref) => create(ref as OtherUserProfilePageStoreRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ProfilePageStore> createElement() {
    return _OtherUserProfilePageStoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OtherUserProfilePageStoreProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OtherUserProfilePageStoreRef on AutoDisposeProviderRef<ProfilePageStore> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _OtherUserProfilePageStoreProviderElement
    extends AutoDisposeProviderElement<ProfilePageStore>
    with OtherUserProfilePageStoreRef {
  _OtherUserProfilePageStoreProviderElement(super.provider);

  @override
  int get userId => (origin as OtherUserProfilePageStoreProvider).userId;
}

String _$currentUserProfilePageStoreHash() =>
    r'08e8261deede046d7bdda9bc894088a50c6185b6';

/// See also [currentUserProfilePageStore].
@ProviderFor(currentUserProfilePageStore)
final currentUserProfilePageStoreProvider =
    AutoDisposeProvider<ProfilePageStore>.internal(
  currentUserProfilePageStore,
  name: r'currentUserProfilePageStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserProfilePageStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentUserProfilePageStoreRef
    = AutoDisposeProviderRef<ProfilePageStore>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfilePageStore on _ProfilePageStore, Store {
  Computed<int>? _$likesComputed;

  @override
  int get likes => (_$likesComputed ??=
          Computed<int>(() => super.likes, name: '_ProfilePageStore.likes'))
      .value;
  Computed<List<PostModel>>? _$postsComputed;

  @override
  List<PostModel> get posts =>
      (_$postsComputed ??= Computed<List<PostModel>>(() => super.posts,
              name: '_ProfilePageStore.posts'))
          .value;
  Computed<int>? _$followersComputed;

  @override
  int get followers =>
      (_$followersComputed ??= Computed<int>(() => super.followers,
              name: '_ProfilePageStore.followers'))
          .value;
  Computed<bool>? _$isAdminProfileComputed;

  @override
  bool get isAdminProfile =>
      (_$isAdminProfileComputed ??= Computed<bool>(() => super.isAdminProfile,
              name: '_ProfilePageStore.isAdminProfile'))
          .value;
  Computed<bool>? _$isOwnProfileComputed;

  @override
  bool get isOwnProfile =>
      (_$isOwnProfileComputed ??= Computed<bool>(() => super.isOwnProfile,
              name: '_ProfilePageStore.isOwnProfile'))
          .value;

  late final _$_selfUserIdAtom =
      Atom(name: '_ProfilePageStore._selfUserId', context: context);

  @override
  int? get _selfUserId {
    _$_selfUserIdAtom.reportRead();
    return super._selfUserId;
  }

  @override
  set _selfUserId(int? value) {
    _$_selfUserIdAtom.reportWrite(value, super._selfUserId, () {
      super._selfUserId = value;
    });
  }

  late final _$_userAtom =
      Atom(name: '_ProfilePageStore._user', context: context);

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

  late final _$_isLoadingAtom =
      Atom(name: '_ProfilePageStore._isLoading', context: context);

  bool get isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  bool get _isLoading => isLoading;

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_isFollowingUserAtom =
      Atom(name: '_ProfilePageStore._isFollowingUser', context: context);

  bool get isFollowingUser {
    _$_isFollowingUserAtom.reportRead();
    return super._isFollowingUser;
  }

  @override
  bool get _isFollowingUser => isFollowingUser;

  @override
  set _isFollowingUser(bool value) {
    _$_isFollowingUserAtom.reportWrite(value, super._isFollowingUser, () {
      super._isFollowingUser = value;
    });
  }

  late final _$loadAsyncAction =
      AsyncAction('_ProfilePageStore.load', context: context);

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$blockUserAsyncAction =
      AsyncAction('_ProfilePageStore.blockUser', context: context);

  @override
  Future<bool> blockUser() {
    return _$blockUserAsyncAction.run(() => super.blockUser());
  }

  late final _$toggleUserFollowAsyncAction =
      AsyncAction('_ProfilePageStore.toggleUserFollow', context: context);

  @override
  Future<bool> toggleUserFollow() {
    return _$toggleUserFollowAsyncAction.run(() => super.toggleUserFollow());
  }

  @override
  String toString() {
    return '''
likes: ${likes},
posts: ${posts},
followers: ${followers},
isAdminProfile: ${isAdminProfile},
isOwnProfile: ${isOwnProfile}
    ''';
  }
}
