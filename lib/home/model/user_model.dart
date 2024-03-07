import 'package:json_annotation/json_annotation.dart';
import 'package:mewtwo/home/model/brand_sizing_model.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/utils.dart';

part 'user_model.g.dart';

enum MeasurementPrivacy {
  all,
  following,
  unknown
}

@JsonSerializable(explicitToJson: true)
class UserModel {
  @JsonKey(
    fromJson: Utility.parseInt,
    toJson: Utility.int2Str
  )
  final int id;
  @JsonKey(
    fromJson: Utility.parseInt,
    toJson: Utility.int2Str
  )
  final int followers;

  
  @JsonKey(fromJson: Utility.parseBool, toJson: Utility.bool2int)
  final bool my_follow;
  @JsonKey(fromJson: Utility.parseStr)
  final String styles;
  final String username, name, photo_url;
  final String? email, password, pronouns, weight, height, bust, waist, hips;
  final List<PostModel>? posts;

  final List<BrandSizingModel>? brandSizings;

  @JsonKey(fromJson: _parseMeasurementPrivacy, toJson: _getMeasurementPrivacy)
  final MeasurementPrivacy measurementPrivacy;

  
  static MeasurementPrivacy _parseMeasurementPrivacy(String? privacyString) {
    return MeasurementPrivacy.values.asNameMap()[privacyString] ?? MeasurementPrivacy.unknown;
  }

  static String _getMeasurementPrivacy(MeasurementPrivacy privacyEnum) {
    return privacyEnum.name;
  }
  

  UserModel(
      {required this.id,
      required this.followers,
      required this.my_follow,
      required this.styles,
      required this.username,
      required this.name,
      required this.photo_url,
      required this.weight,
      required this.height,
      required this.bust,
      required this.waist,
      required this.hips,
      required this.measurementPrivacy,
      required this.brandSizings,
      this.posts,
      this.email,
      this.password,
      this.pronouns});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
