// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_content_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReportContentStore on _ReportContentStore, Store {
  late final _$_isLoadingAtom =
      Atom(name: '_ReportContentStore._isLoading', context: context);

  bool get isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  bool get _isLoading => isLoading;

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
    });
  }

  late final _$_isSubmitButtonEnabledAtom = Atom(
      name: '_ReportContentStore._isSubmitButtonEnabled', context: context);

  bool get isSubmitButtonEnabled {
    _$_isSubmitButtonEnabledAtom.reportRead();
    return super._isSubmitButtonEnabled;
  }

  @override
  bool get _isSubmitButtonEnabled => isSubmitButtonEnabled;

  @override
  set _isSubmitButtonEnabled(bool value) {
    _$_isSubmitButtonEnabledAtom
        .reportWrite(value, super._isSubmitButtonEnabled, () {
      super._isSubmitButtonEnabled = value;
    });
  }

  late final _$submitReportAsyncAction =
      AsyncAction('_ReportContentStore.submitReport', context: context);

  @override
  Future<bool> submitReport({required ReportType type, required String id}) {
    return _$submitReportAsyncAction
        .run(() => super.submitReport(type: type, id: id));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
