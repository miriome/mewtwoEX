// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drop_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropPostModel _$DropPostModelFromJson(Map<String, dynamic> json) =>
    DropPostModel(
      isBuyable: Utility.parseBool(json['isBuyable']),
      id: json['id'] as int,
      title: json['title'] as String,
      isPetite: Utility.parseBool(json['isPetite']),
      imageUrl: json['imageUrl'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => DropPostImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      caption: json['caption'] as String,
      price: json['price'] as String,
      condition: json['condition'] as String,
      size: json['size'] as String,
      userData: UserModel.fromJson(json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DropPostModelToJson(DropPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'isPetite': instance.isPetite,
      'price': instance.price,
      'condition': instance.condition,
      'size': instance.size,
      'isBuyable': instance.isBuyable,
      'userData': instance.userData.toJson(),
      'images': instance.images.map((e) => e.toJson()).toList(),
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
