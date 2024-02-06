import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/mew.dart';
import 'package:mobx/mobx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mewtwo/home/model/user_model.dart';

part 'current_user_store.g.dart';


@Riverpod(keepAlive: true)
CurrentUserStore currentUserStore(CurrentUserStoreRef ref) {
  final store = CurrentUserStore();
  store.load();
  return store;
}

class CurrentUserStore extends _CurrentUserStore with _$CurrentUserStore {}

abstract class _CurrentUserStore with Store {

  @readonly
  UserModel? _user;

  @action
  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    int? selfUserId;
    if (sp.containsKey(Constants.kKeyId)) {
      selfUserId = sp.getInt(Constants.kKeyId);
    }
    if (selfUserId == null) {
      return;
    }
    final userInfoApiProvider = GetUserInfoApiProvider(userId: selfUserId);
    final res = await Mew.pc.read(userInfoApiProvider.future);
    if (res != null) {
      _user = res;
    }
  }
}