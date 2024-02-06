import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/profile/api/api.dart';
import 'package:mewtwo/unauth/pages/onboarding/select_style_page/select_style_page_store.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_styles_page_store.g.dart';

class EditStylesPageStore extends _EditStylesPageStore with _$EditStylesPageStore {
  EditStylesPageStore({required super.store});
 
}

abstract class _EditStylesPageStore with Store {
  final SelectStylePageStore store;
  _EditStylesPageStore({required this.store});
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
      store.selectedStyles.addAll(res.styles.split(','));
    }
  }

  @action
  Future<bool> editStyles(Set<String> styles) async {
    final userInfoApiProvider = EditStylesApiProvider(styles: styles);
    final res = await Mew.pc.read(userInfoApiProvider.future);
    return res;
  }
}
