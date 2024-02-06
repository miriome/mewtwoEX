// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      json['id'] as String,
      json['user_id'] as String,
      json['post_id'] as String,
      json['content'] as String,
      json['sent_by'] as String,
      json['created_at'] as String,
      notification_type: NotificationModel.getNotificationType(
          json['notification_type'] as String),
      postData: json['postData'] == null
          ? null
          : PostModel.fromJson(json['postData'] as Map<String, dynamic>),
      userData: UserModel.fromJson(json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'notification_type':
          _$NotificationTypeEnumMap[instance.notification_type]!,
      'postData': instance.postData?.toJson(),
      'userData': instance.userData.toJson(),
      'id': instance.id,
      'user_id': instance.user_id,
      'post_id': instance.post_id,
      'content': instance.content,
      'sent_by': instance.sent_by,
      'created_at': instance.created_at,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.comment: 'comment',
  NotificationType.like: 'like',
  NotificationType.follow: 'follow',
  NotificationType.mention: 'mention',
  NotificationType.unknown: 'unknown',
};
