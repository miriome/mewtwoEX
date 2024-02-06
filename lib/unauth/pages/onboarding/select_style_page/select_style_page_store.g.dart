// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_style_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelectStylePageStore on _SelectStylePageStore, Store {
  late final _$selectedStylesAtom =
      Atom(name: '_SelectStylePageStore.selectedStyles', context: context);

  @override
  ObservableSet<String> get selectedStyles {
    _$selectedStylesAtom.reportRead();
    return super.selectedStyles;
  }

  @override
  set selectedStyles(ObservableSet<String> value) {
    _$selectedStylesAtom.reportWrite(value, super.selectedStyles, () {
      super.selectedStyles = value;
    });
  }

  @override
  String toString() {
    return '''
selectedStyles: ${selectedStyles}
    ''';
  }
}
