import 'package:flutter/material.dart';
import 'package:mewtwo/home/model/brand_sizing_model.dart';
import 'package:mobx/mobx.dart';

part 'sml_measurement_form_store.g.dart';

class _BrandSizingStore extends __BrandSizingStore with _$_BrandSizingStore {}

abstract class __BrandSizingStore with Store {
  @observable
  String brand = "";
  @observable
  String size = "";
  String key = UniqueKey().toString();
}

class SmlMeasurementFormStore extends _SmlMeasurementFormStore with _$SmlMeasurementFormStore {
  SmlMeasurementFormStore(super.brandSizings);
}

abstract class _SmlMeasurementFormStore with Store {
  final List<BrandSizingModel> brandSizings;
  _SmlMeasurementFormStore(this.brandSizings);
  @observable
  ObservableMap<String, ObservableList<_BrandSizingStore>> clothingSizings = ObservableMap.of({});

  @computed
  Set<String> get availableClothingTypes => brandSizings.map((e) => e.clothing_type).toSet();

  List<({String brand, String brandName})> getBrandOptions(String clothingType) {
    return brandSizings
        .where((element) => element.clothing_type == clothingType)
        .map((e) => (brand: e.brand, brandName: e.brand_name))
        .toSet()
        .toList();
  }

  List<String> getSizeOptions(String clothingType) {
    return brandSizings.where((element) => element.clothing_type == clothingType).map((e) => e.size).toSet().toList();
  }

  @action
  void addSize(String category) {
    if (clothingSizings[category] != null) {
      clothingSizings[category]!.add(_BrandSizingStore());
    } else {
      clothingSizings[category] = ObservableList.of([_BrandSizingStore()]);
    }
  }

  @action
  void removeSize({required String clothingType, required int index}) {
    clothingSizings[clothingType]?.removeAt(index);
  }
}
