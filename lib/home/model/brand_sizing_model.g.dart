// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_sizing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandSizingModel _$BrandSizingModelFromJson(Map<String, dynamic> json) =>
    BrandSizingModel(
      brand_name: json['brand_name'] as String,
      clothing_type: json['clothing_type'] as String,
      size: json['size'] as String,
    );

Map<String, dynamic> _$BrandSizingModelToJson(BrandSizingModel instance) =>
    <String, dynamic>{
      'brand_name': instance.brand_name,
      'clothing_type': instance.clothing_type,
      'size': instance.size,
    };
