import 'package:mobx/mobx.dart';

part 'sml_measurement_form_store.g.dart';

class SmlMeasurementFormStore extends _SmlMeasurementFormStore with _$SmlMeasurementFormStore {}

class BrandSizing{
  String brand = "";
  String size = "";
}


abstract class _SmlMeasurementFormStore with Store {
  ObservableMap<String, ObservableList<BrandSizing>> clothingSizings = ObservableMap.of({});

  List<String> get availableClothingCategories => ["Tops"];
}
