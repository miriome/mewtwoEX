import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/mew.dart';

import 'package:mewtwo/profile/upsert_measurements/upsert_measurements_base/components/sml_measurement_form/sml_measurement_form_store.dart';
import 'package:mewtwo/unauth/api/api.dart';
import 'package:mobx/mobx.dart';

part 'upsert_measurements_base_store.g.dart';

class UpsertMeasurementsBaseStore extends _UpsertMeasurementsBaseStore with _$UpsertMeasurementsBaseStore {}

abstract class _UpsertMeasurementsBaseStore with Store {
  final formKey = GlobalKey<FormBuilderState>();
  final smlMeasurementStore = SmlMeasurementFormStore();

  @observable
  int? height;

  @observable
  int? bust;
  @observable
  int? waist;
  @observable
  int? hips;

  @observable
  bool hideFromNonFollowers = false;

  @action
  Future<bool> submit() async {
    if (!formKey.currentState!.validate(autoScrollWhenFocusOnInvalid: false, focusOnInvalid: false)) {
      return false;
    }

    formKey.currentState!.save();

    final editMeasurementsProvider = EditMeasurementsApiProvider(
        height: height,
        bust: bust,
        waist: waist,
        hips: hips,
        privacy: hideFromNonFollowers ? MeasurementPrivacy.following : MeasurementPrivacy.all,
        brandSizings: smlMeasurementStore.getDataset());
    return await Mew.pc.read(editMeasurementsProvider.future);
  }
}
