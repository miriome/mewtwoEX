import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:mewtwo/home/model/brand_sizing_model.dart';
import 'package:mewtwo/profile/upsert_measurements/stores/brand_sizing_store.dart';
import 'package:mobx/mobx.dart';

part 'sml_measurement_form_store.g.dart';

class SmlMeasurementFormStore extends _SmlMeasurementFormStore with _$SmlMeasurementFormStore {}

abstract class _SmlMeasurementFormStore with Store {
  @observable
  ObservableList<BrandSizingModel> brandSizings = ObservableList.of([]);

  @observable
  ObservableMap<String, ObservableList<BrandSizingStore>> clothingSizings = ObservableMap.of({});

  @computed
  Set<String> get availableClothingTypes => brandSizings.map((e) => e.clothing_type).toSet();

  List<String> getBrandOptions({required String clothingType, required int sizingIndex}) {
    final sizings = brandSizings
        .where((element) => element.clothing_type == clothingType)
        .where((element) => clothingSizings[clothingType]![sizingIndex].size.isEmpty || element.size == clothingSizings[clothingType]![sizingIndex].size)
        // .where((element) => !(clothingSizings[clothingType]?.map((element) => element.brandName).contains(element.brand_name) ?? true))
        .map((e) => e.brand_name)
        .toSet()
        .toList();
    return sizings;
  }

  List<String> getSizeOptions({required String clothingType, required int sizingIndex}) {
    return brandSizings.where((element) => element.clothing_type == clothingType)
    .where((element) => clothingSizings[clothingType]![sizingIndex].brandName.isEmpty || element.brand_name == (clothingSizings[clothingType]![sizingIndex].brandName))
    .map((e) => e.size).toSet().toList();
  }


  @action
  void addSize(String category) {
    if (clothingSizings[category] != null) {
      clothingSizings[category]!.add(BrandSizingStore());
    } else {
      clothingSizings[category] = ObservableList.of([BrandSizingStore()]);
    }
  }

  @action
  void removeSize({required String clothingType, required int index}) {
    clothingSizings[clothingType]?.removeAt(index);
  }

  // TODO: This heavily needs refactoring
  List<({String brandName, String clothingType, String size})> getDataset() {
    List<({String brandName, String clothingType, String size})> result = [];
    for (final entry in clothingSizings.entries) {
      final clothingType = entry.key;
      for (final sizing in entry.value) {
        result.add((clothingType: clothingType, brandName: sizing.brandName, size: sizing.size));
      }
    }
    return result;
  }
}
