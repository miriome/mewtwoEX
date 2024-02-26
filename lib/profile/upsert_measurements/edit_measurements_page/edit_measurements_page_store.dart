import 'package:mewtwo/constants.dart';
import 'package:mewtwo/home/api/api.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/profile/upsert_measurements/stores/brand_sizing_store.dart';
import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/upsert_measurements_base_store.dart';
import 'package:mewtwo/utils.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_measurements_page_store.g.dart';

class EditMeasurementsPageStore = AbsEditMeasurementsPageStore with _$EditMeasurementsPageStore;

abstract class AbsEditMeasurementsPageStore extends UpsertMeasurementsBaseStore with Store {
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
      bust = res.bust != null ? Utility.parseInt(res.bust) : null;
      height = res.height != null ? Utility.parseInt(res.height) : null;
      hips = res.hips != null ? Utility.parseInt(res.hips) : null;
      waist = res.waist != null ? Utility.parseInt(res.waist) : null;
      hideFromNonFollowers = res.measurementPrivacy == MeasurementPrivacy.following;
      formKey.currentState!.patchValue({
        if (bust != null && bust != 0) 'bust': Utility.parseInt(res.bust).toString(),
        if (height != null && height != 0) 'height': Utility.parseInt(res.height).toString(),
        if (hips != null && hips != 0) 'hips': Utility.parseInt(res.hips).toString(),
        if (waist != null && waist != 0) 'waist': Utility.parseInt(res.waist).toString(),
        'measurementPrivacy': hideFromNonFollowers
      });
      for (final e in res.brandSizings ?? []) {
        if (smlMeasurementStore.clothingSizings[e.clothing_type] == null) {
          smlMeasurementStore.clothingSizings[e.clothing_type] = ObservableList.of([
            BrandSizingStore()
              ..brandName = e.brand_name
              ..size = e.size
          ]);
        } else {
          smlMeasurementStore.clothingSizings[e.clothing_type]!.add(BrandSizingStore()
            ..brandName = e.brand_name
            ..size = e.size);
        }
      }
    }
  }
}
