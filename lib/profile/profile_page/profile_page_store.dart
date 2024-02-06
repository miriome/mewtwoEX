import 'package:dartx/dartx.dart';
import 'package:mewtwo/base/stores/current_user_store.dart';
import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/utils.dart';
import 'package:mobx/mobx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_page_store.g.dart';

@riverpod
ProfilePageStore otherUserProfilePageStore(OtherUserProfilePageStoreRef ref, {required int userId}) {
  final store = ProfilePageStore(userId);
  store.init().then((value) => store.load());
  return store;
}

@riverpod
ProfilePageStore currentUserProfilePageStore(CurrentUserProfilePageStoreRef ref) {
  final store = ProfilePageStore(null);
  store.init().then((value) => store.load());
  return store;
}

class ProfilePageStore extends _ProfilePageStore with _$ProfilePageStore {
  ProfilePageStore(int? userId) : super(userId);
}

abstract class _ProfilePageStore with Store {
  int? _userId;
  _ProfilePageStore(this._userId);

  @observable
  int? _selfUserId;

  Future<void> init() async {
    
    final sp = await SharedPreferences.getInstance();
    if (sp.containsKey(Constants.kKeyId)) {
      _userId ??= sp.getInt(Constants.kKeyId);
      _selfUserId = sp.getInt(Constants.kKeyId);
    }
    
  }

  @readonly
  UserModel? _user;

  @computed
  int get likes => _user?.posts?.map((post) => post.likes).sum() ?? 0;

  @computed
  List<PostModel> get posts => _user?.posts ?? [];

  @computed
  int get followers => _user?.followers ?? 0;

  @computed
  bool get isAdminProfile => _userId != null ? Utility.isAdmin(_userId!) : false;

  @computed
  bool get isOwnProfile => _userId == _selfUserId && _selfUserId != null;

  @readonly
  bool _isLoading = false;

  @readonly
  bool _isFollowingUser = false;

  @action
  Future<void> load() async {
    if (isOwnProfile) {
      final currentUserStore = Mew.pc.read(currentUserStoreProvider);
      await currentUserStore.load();
      
      if (currentUserStore.user != null) {
      _user = currentUserStore.user;
      _isFollowingUser = currentUserStore.user!.my_follow;
    }

    }
    // TODO: Maybe shouldnt be null. Even home page should pass in a user ID instead.
    final userIdToLoad = _userId ?? _selfUserId;

    if (userIdToLoad == null) {
      return;
    }
    final userInfoApiProvider = GetUserInfoApiProvider(userId: userIdToLoad);
    final res = await Mew.pc.read(userInfoApiProvider.future);
    if (res != null) {
      _user = res;
      _isFollowingUser = res.my_follow;
    }
  }

  @action
  Future<bool> blockUser() async {
    final userIdToBlock = _userId ?? _selfUserId;
    if (userIdToBlock == null) {
      return false;
    }
    if (isOwnProfile) {
      return false;
    }
    final blockUserApiProvider = BlockUserApiProvider(userId: userIdToBlock);
    final listener = Mew.pc.listen(blockUserApiProvider, (previous, next) {
      _isLoading = next.isLoading;
    });
    final res = await Mew.pc.read(blockUserApiProvider.future);
    listener.close();
    return res;
  }

  @action
  Future<bool> toggleUserFollow() async {
    final userIdToBlock = _userId ?? _selfUserId;
    if (userIdToBlock == null) {
      return false;
    }
    if (isOwnProfile) {
      return false;
    }
    final blockUserApiProvider = ToggleUserFollowApiProvider(userId: userIdToBlock, followToggle: !_isFollowingUser);
    final res = await Mew.pc.read(blockUserApiProvider.future);
    load();
    return res;
  }
}
