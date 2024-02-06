import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/networking/networking.dart';
import 'package:mewtwo/profile/upsert_profile/widgets/upsert_profile_base/upsert_profile_base_store.dart';
import 'package:mobx/mobx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_profile_page_store.g.dart';

@riverpod
EditProfilePageStore editProfilePageStore(EditProfilePageStoreRef ref) {
  final store = EditProfilePageStore();
  store.load();
  ref.onDispose(() {
    store.dispose();
   });
   return store;
}

class EditProfilePageStore = AbsProfilePageStore with _$EditProfilePageStore;

abstract class AbsProfilePageStore extends UpsertProfileBaseStore with Store {
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
      nameController.text = res.name;
      // TODO: Fix domain passing
      if (res.photo_url !=  Networking.imageDomain) {
        displayImagePath = res.photo_url;
      }

    }
  }
}