// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drop_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropPostModel _$DropPostModelFromJson(Map<String, dynamic> json) =>
    DropPostModel(
      isSold: Utility.parseBool(json['isSold']),
      id: Utility.parseInt(json['id']),
      title: json['title'] as String,
      isPetite: Utility.parseBool(json['isPetite']),
      images: (json['images'] as List<dynamic>)
          .map((e) => DropPostImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      caption: json['caption'] as String,
      price: json['price'] as String,
      condition: json['condition'] as String,
      clothingSize: json['clothingSize'] as String,
      numberSizing: json['numberSizing'] == null
          ? null
          : NumberMeasurementModel.fromJson(
              json['numberSizing'] as Map<String, dynamic>),
      brandSizing: (json['brandSizing'] as List<dynamic>?)
          ?.map((e) => BrandSizingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DropPostModelToJson(DropPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isPetite': instance.isPetite,
      'price': instance.price,
      'condition': instance.condition,
      'clothingSize': instance.clothingSize,
      'isSold': instance.isSold,
      'images': instance.images.map((e) => e.toJson()).toList(),
      'numberSizing': instance.numberSizing?.toJson(),
      'brandSizing': instance.brandSizing?.map((e) => e.toJson()).toList(),
      'caption': instance.caption,
    };

DropPostImageModel _$DropPostImageModelFromJson(Map<String, dynamic> json) =>
    DropPostImageModel(
      image: Utility.parseImageUrl(json['image'] as String),
      index: Utility.parseInt(json['index']),
    );

Map<String, dynamic> _$DropPostImageModelToJson(DropPostImageModel instance) =>
    <String, dynamic>{
      'image': instance.image,
      'index': Utility.int2Str(instance.index),
    };
