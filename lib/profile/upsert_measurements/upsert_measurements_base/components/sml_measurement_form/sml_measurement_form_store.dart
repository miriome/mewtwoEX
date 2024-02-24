import 'package:flutter/material.dart';
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



class SmlMeasurementFormStore extends _SmlMeasurementFormStore with _$SmlMeasurementFormStore {}



abstract class _SmlMeasurementFormStore with Store {
  @observable
  ObservableMap<String, ObservableList<_BrandSizingStore>> clothingSizings = ObservableMap.of({});

  List<String> get availableClothingCategories => ["Tops"];

  @action
  void addSize(String category) {
    if (clothingSizings[category] != null) {
      clothingSizings[category]!.add(_BrandSizingStore());
    } else {
      clothingSizings[category] = ObservableList.of([_BrandSizingStore()]);
      
    }
  }

  @action
  void removeSize({required String category, required int index}) {
    clothingSizings[category]?.removeAt(index);
  }
}
