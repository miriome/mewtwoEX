// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      json['sender_id'] as int,
      json['receiver_id'] as int,
      json['message'] as String,
      json['content_type'] as String,
      (json['time'] as num).toDouble(),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'sender_id': instance.sender_id,
      'receiver_id': instance.receiver_id,
      'message': instance.message,
      'content_type': instance.content_type,
      'time': instance.time,
    };
