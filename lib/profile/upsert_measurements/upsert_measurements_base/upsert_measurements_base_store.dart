import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/mew.dart';
import 'package:mewtwo/unauth/api/api.dart';
import 'package:mobx/mobx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upsert_measurements_base_store.g.dart';


class UpsertMeasurementsBaseStore extends _UpsertMeasurementsBaseStore with _$UpsertMeasurementsBaseStore {}

abstract class _UpsertMeasurementsBaseStore with Store {
  final formKey = GlobalKey<FormBuilderState>();
  
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
    formKey.currentState!.save();
    final editMeasurementsProvider = EditMeasurementsApiProvider(
        height: height,
        bust: bust,
        waist: waist,
        hips: hips,
        privacy: hideFromNonFollowers ? MeasurementPrivacy.following : MeasurementPrivacy.all);
    return await Mew.pc.read(editMeasurementsProvider.future);
  }
}
