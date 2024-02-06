// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchApiModel _$SearchApiModelFromJson(Map<String, dynamic> json) =>
    SearchApiModel(
      postData: (json['postData'] as List<dynamic>?)
          ?.map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      userData: (json['userData'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchApiModelToJson(SearchApiModel instance) =>
    <String, dynamic>{
      'postData': instance.postData?.map((e) => e.toJson()).toList(),
      'userData': instance.userData?.map((e) => e.toJson()).toList(),
    };
