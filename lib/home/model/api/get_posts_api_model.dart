
import 'package:json_annotation/json_annotation.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/utils.dart';
part 'get_posts_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetPostsApiModel {
  
  final int followers;
  final List<PostModel> data;

  GetPostsApiModel({required this.followers, required this.data});

    /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetPostsApiModel.fromJson(Map<String, dynamic> json) => _$GetPostsApiModelFromJson(json);

  /// Connect the generated [_$GetPostsApiModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GetPostsApiModelToJson(this);
  
}