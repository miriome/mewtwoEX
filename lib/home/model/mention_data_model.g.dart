// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mention_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MentionDataModel _$MentionDataModelFromJson(Map<String, dynamic> json) =>
    MentionDataModel(
      user_id: Utility.parseInt(json['user_id']),
      username: json['username'] as String,
    );

Map<String, dynamic> _$MentionDataModelToJson(MentionDataModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'username': instance.username,
    };
