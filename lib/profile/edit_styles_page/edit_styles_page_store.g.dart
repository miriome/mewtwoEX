// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_styles_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditStylesPageStore on _EditStylesPageStore, Store {
  late final _$loadAsyncAction =
      AsyncAction('_EditStylesPageStore.load', context: context);

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  late final _$editStylesAsyncAction =
      AsyncAction('_EditStylesPageStore.editStyles', context: context);

  @override
  Future<bool> editStyles(Set<String> styles) {
    return _$editStylesAsyncAction.run(() => super.editStyles(styles));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
