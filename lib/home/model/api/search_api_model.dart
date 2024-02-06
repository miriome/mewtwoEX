
import 'package:json_annotation/json_annotation.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/utils.dart';
part 'search_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchApiModel {
  
  final List<PostModel>? postData;
  final List<UserModel>? userData;

  SearchApiModel({required this.postData, required this.userData});

    /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory SearchApiModel.fromJson(Map<String, dynamic> json) => _$SearchApiModelFromJson(json);

  /// Connect the generated [_$SearchApiModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SearchApiModelToJson(this);
  
}