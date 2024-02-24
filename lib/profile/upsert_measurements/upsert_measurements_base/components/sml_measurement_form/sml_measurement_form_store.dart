import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'sml_measurement_form_store.g.dart';

class SmlMeasurementFormStore extends _SmlMeasurementFormStore with _$SmlMeasurementFormStore {}

class BrandSizing {
  String brand = "";
  String size = "";
  String key = UniqueKey().toString();
}

abstract class _SmlMeasurementFormStore with Store {
  @observable
  ObservableMap<String, ObservableList<BrandSizing>> clothingSizings = ObservableMap.of({});

  List<String> get availableClothingCategories => ["Tops"];

  @action
  void addSize(String category) {
    if (clothingSizings[category] != null) {
      clothingSizings[category]!.add(BrandSizing());
    } else {
      clothingSizings[category] = ObservableList.of([BrandSizing()]);
      
    }
  }

  @action
  void removeSize({required String category, required int index}) {
    clothingSizings[category]?.removeAt(index);
  }
}
