import 'package:json_annotation/json_annotation.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/utils.dart';
part 'drop_post_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DropPostModel {
  final int id;
  final String title;
  final String imageUrl;
  @JsonKey(fromJson: Utility.parseBool)
  final bool isPetite;
  final String price;
  final String condition;
  final String size;
  @JsonKey(fromJson: Utility.parseBool)
  final bool isBuyable;
  final UserModel userData;
  final List<DropPostImageModel> images;

  final String caption;

  DropPostModel(
      {required this.isBuyable,
      required this.id,
      required this.title,
      required this.isPetite,
      required this.imageUrl,
      required this.images,
      required this.caption,
      required this.price,
      required this.condition,
      required this.size,
      required this.userData});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory DropPostModel.fromJson(Map<String, dynamic> json) => _$DropPostModelFromJson(json);

  /// Connect the generated [_$NotificationModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DropPostModelToJson(this);
}

@JsonSerializable()
class DropPostImageModel {
  @JsonKey(fromJson: Utility.parseImageUrl)
  final String image;
  @JsonKey(fromJson: Utility.parseInt, toJson: Utility.int2Str)
  final int index;
  DropPostImageModel({required this.image, required this.index});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory DropPostImageModel.fromJson(Map<String, dynamic> json) => _$DropPostImageModelFromJson(json);

  /// Connect the generated [_$DropPostImageModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DropPostImageModelToJson(this);
}
