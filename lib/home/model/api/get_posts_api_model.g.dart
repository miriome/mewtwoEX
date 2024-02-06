// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_posts_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostsApiModel _$GetPostsApiModelFromJson(Map<String, dynamic> json) =>
    GetPostsApiModel(
      followers: json['followers'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPostsApiModelToJson(GetPostsApiModel instance) =>
    <String, dynamic>{
      'followers': instance.followers,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
