// class
// var id, user_id, post_id, created_timestamp: Int
//     var comment, created_at: String
//     var commented_by: UserModel

import 'package:json_annotation/json_annotation.dart';
import 'package:mewtwo/home/model/mention_data_model.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/utils.dart';

part 'comment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentModel {
  @JsonKey(
    fromJson: Utility.parseInt,
  )
  final int id;
  @JsonKey(
    fromJson: Utility.parseInt,
  )
  final int user_id;
  @JsonKey(
    fromJson: Utility.parseInt,
  )
   final int post_id;
    @JsonKey(
    fromJson: Utility.parseInt,
  )
   final int created_timestamp;
   
  final String comment, created_at;
  final UserModel commented_by;
  
  final List<MentionDataModel> mentions;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory CommentModel.fromJson(Map<String, dynamic> json) => _$CommentModelFromJson(json);

  CommentModel(
      {required this.id,
      required this.user_id,
      required this.post_id,
      required this.created_timestamp,
      required this.comment,
      required this.created_at,
      required this.commented_by,
      required this.mentions
      });

  /// Connect the generated [_$CommentModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
