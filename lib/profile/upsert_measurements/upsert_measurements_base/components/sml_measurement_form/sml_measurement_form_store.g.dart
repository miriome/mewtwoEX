// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sml_measurement_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SmlMeasurementFormStore on _SmlMeasurementFormStore, Store {
  Computed<Set<String>>? _$availableClothingTypesComputed;

  @override
  Set<String> get availableClothingTypes =>
      (_$availableClothingTypesComputed ??= Computed<Set<String>>(
              () => super.availableClothingTypes,
              name: '_SmlMeasurementFormStore.availableClothingTypes'))
          .value;

  late final _$brandSizingsAtom =
      Atom(name: '_SmlMeasurementFormStore.brandSizings', context: context);

  @override
  ObservableList<BrandSizingModel> get brandSizings {
    _$brandSizingsAtom.reportRead();
    return super.brandSizings;
  }

  @override
  set brandSizings(ObservableList<BrandSizingModel> value) {
    _$brandSizingsAtom.reportWrite(value, super.brandSizings, () {
      super.brandSizings = value;
    });
  }

  late final _$clothingSizingsAtom =
      Atom(name: '_SmlMeasurementFormStore.clothingSizings', context: context);

  @override
  ObservableMap<String, ObservableList<BrandSizingStore>> get clothingSizings {
    _$clothingSizingsAtom.reportRead();
    return super.clothingSizings;
  }

  @override
  set clothingSizings(
      ObservableMap<String, ObservableList<BrandSizingStore>> value) {
    _$clothingSizingsAtom.reportWrite(value, super.clothingSizings, () {
      super.clothingSizings = value;
    });
  }

  late final _$_SmlMeasurementFormStoreActionController =
      ActionController(name: '_SmlMeasurementFormStore', context: context);

  @override
  void addSize(String category) {
    final _$actionInfo = _$_SmlMeasurementFormStoreActionController.startAction(
        name: '_SmlMeasurementFormStore.addSize');
    try {
      return super.addSize(category);
    } finally {
      _$_SmlMeasurementFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSize({required String clothingType, required int index}) {
    final _$actionInfo = _$_SmlMeasurementFormStoreActionController.startAction(
        name: '_SmlMeasurementFormStore.removeSize');
    try {
      return super.removeSize(clothingType: clothingType, index: index);
    } finally {
      _$_SmlMeasurementFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
brandSizings: ${brandSizings},
clothingSizings: ${clothingSizings},
availableClothingTypes: ${availableClothingTypes}
    ''';
  }
}
