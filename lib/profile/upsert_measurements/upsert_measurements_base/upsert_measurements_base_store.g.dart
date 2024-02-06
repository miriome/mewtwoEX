// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upsert_measurements_base_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UpsertMeasurementsBaseStore on _UpsertMeasurementsBaseStore, Store {
  late final _$heightAtom =
      Atom(name: '_UpsertMeasurementsBaseStore.height', context: context);

  @override
  int? get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(int? value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  late final _$bustAtom =
      Atom(name: '_UpsertMeasurementsBaseStore.bust', context: context);

  @override
  int? get bust {
    _$bustAtom.reportRead();
    return super.bust;
  }

  @override
  set bust(int? value) {
    _$bustAtom.reportWrite(value, super.bust, () {
      super.bust = value;
    });
  }

  late final _$waistAtom =
      Atom(name: '_UpsertMeasurementsBaseStore.waist', context: context);

  @override
  int? get waist {
    _$waistAtom.reportRead();
    return super.waist;
  }

  @override
  set waist(int? value) {
    _$waistAtom.reportWrite(value, super.waist, () {
      super.waist = value;
    });
  }

  late final _$hipsAtom =
      Atom(name: '_UpsertMeasurementsBaseStore.hips', context: context);

  @override
  int? get hips {
    _$hipsAtom.reportRead();
    return super.hips;
  }

  @override
  set hips(int? value) {
    _$hipsAtom.reportWrite(value, super.hips, () {
      super.hips = value;
    });
  }

  late final _$hideFromNonFollowersAtom = Atom(
      name: '_UpsertMeasurementsBaseStore.hideFromNonFollowers',
      context: context);

  @override
  bool get hideFromNonFollowers {
    _$hideFromNonFollowersAtom.reportRead();
    return super.hideFromNonFollowers;
  }

  @override
  set hideFromNonFollowers(bool value) {
    _$hideFromNonFollowersAtom.reportWrite(value, super.hideFromNonFollowers,
        () {
      super.hideFromNonFollowers = value;
    });
  }

  late final _$submitAsyncAction =
      AsyncAction('_UpsertMeasurementsBaseStore.submit', context: context);

  @override
  Future<bool> submit() {
    return _$submitAsyncAction.run(() => super.submit());
  }

  @override
  String toString() {
    return '''
height: ${height},
bust: ${bust},
waist: ${waist},
hips: ${hips},
hideFromNonFollowers: ${hideFromNonFollowers}
    ''';
  }
}
