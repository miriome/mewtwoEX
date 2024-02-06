// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: Utility.parseInt(json['id']),
      followers: Utility.parseInt(json['followers']),
      my_follow: Utility.parseBool(json['my_follow']),
      styles: Utility.parseStr(json['styles']),
      username: json['username'] as String,
      name: json['name'] as String,
      photo_url: json['photo_url'] as String,
      weight: json['weight'] as String?,
      height: json['height'] as String?,
      bust: json['bust'] as String?,
      waist: json['waist'] as String?,
      hips: json['hips'] as String?,
      measurementPrivacy: UserModel._parseMeasurementPrivacy(
          json['measurementPrivacy'] as String?),
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      email: json['email'] as String?,
      password: json['password'] as String?,
      pronouns: json['pronouns'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': Utility.int2Str(instance.id),
      'followers': Utility.int2Str(instance.followers),
      'my_follow': Utility.bool2int(instance.my_follow),
      'styles': instance.styles,
      'username': instance.username,
      'name': instance.name,
      'photo_url': instance.photo_url,
      'email': instance.email,
      'password': instance.password,
      'pronouns': instance.pronouns,
      'weight': instance.weight,
      'height': instance.height,
      'bust': instance.bust,
      'waist': instance.waist,
      'hips': instance.hips,
      'posts': instance.posts?.map((e) => e.toJson()).toList(),
      'measurementPrivacy':
          UserModel._getMeasurementPrivacy(instance.measurementPrivacy),
    };
