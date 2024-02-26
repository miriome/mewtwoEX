// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_sizing_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BrandSizingStore on _BrandSizingStore, Store {
  late final _$brandNameAtom =
      Atom(name: '_BrandSizingStore.brandName', context: context);

  @override
  String get brandName {
    _$brandNameAtom.reportRead();
    return super.brandName;
  }

  @override
  set brandName(String value) {
    _$brandNameAtom.reportWrite(value, super.brandName, () {
      super.brandName = value;
    });
  }

  late final _$sizeAtom =
      Atom(name: '_BrandSizingStore.size', context: context);

  @override
  String get size {
    _$sizeAtom.reportRead();
    return super.size;
  }

  @override
  set size(String value) {
    _$sizeAtom.reportWrite(value, super.size, () {
      super.size = value;
    });
  }

  @override
  String toString() {
    return '''
brandName: ${brandName},
size: ${size}
    ''';
  }
}
