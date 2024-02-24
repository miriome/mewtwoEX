import 'package:json_annotation/json_annotation.dart';

import 'package:mewtwo/utils.dart';

part 'brand_sizing_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BrandSizingModel {
  
  final String brand_name;

  final String brand;
  
  final String clothing_type;

  final String size;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory BrandSizingModel.fromJson(Map<String, dynamic> json) => _$BrandSizingModelFromJson(json);

  BrandSizingModel({required this.brand, required this.brand_name, required this.clothing_type, required this.size});

  /// Connect the generated [_$BrandSizingModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BrandSizingModelToJson(this);
}
