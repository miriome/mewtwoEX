// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
      Utility.parseInt(json['target_id']),
      json['last_message'] as String,
      Utility.parseInt(json['last_timestamp']),
      json['last_date'] as String,
      UserModel.fromJson(json['contactUser'] as Map<String, dynamic>),
      id: Utility.parseInt(json['id']),
    );

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'id': Utility.int2Str(instance.id),
      'target_id': Utility.int2Str(instance.target_id),
      'last_message': instance.last_message,
      'last_timestamp': Utility.int2Str(instance.last_timestamp),
      'last_date': instance.last_date,
      'contactUser': instance.contactUser.toJson(),
    };
