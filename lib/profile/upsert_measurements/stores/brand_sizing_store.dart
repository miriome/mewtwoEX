import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'brand_sizing_store.g.dart';

class BrandSizingStore extends _BrandSizingStore with _$BrandSizingStore {}

abstract class _BrandSizingStore with Store {
  @observable
  String brandName = "";
  @observable
  String size = "";
  String key = UniqueKey().toString();
}
