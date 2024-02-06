import 'package:json_annotation/json_annotation.dart';
import 'package:mewtwo/home/model/comment_model.dart';
import 'package:mewtwo/home/model/mention_data_model.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/utils.dart';
import 'package:mobx/mobx.dart';

part 'post_model.g.dart';


@JsonSerializable(explicitToJson: true)
class PostModel extends _PostModel with _$PostModel {
  PostModel({
    required super.image,
    required super.caption,
    required super.hypertext,
    required super.hyperlink,
    required super.created_at,
    required super.id,
    required super.chat_enabled,
    required super.added_by,
    required super.likes,
    required super.my_like,
    required super.images,
    required super.views,
    super.hashtag,
    super.posted_by,
    super.comments,
    super.mentions
  });
  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);

  /// Connect the generated [_$PostModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}


abstract class _PostModel with Store {
  final String image; // TODO: Deprecate
  final String caption;
  final String hypertext;
  final String hyperlink;
  final String created_at;
  @JsonKey(
    fromJson: Utility.parseInt,
    toJson: Utility.int2Str
  )
  final int id;
  //try. if not stick to int
  @JsonKey(
    fromJson: Utility.parseBool,
    toJson: Utility.bool2int
  )
  final bool chat_enabled;
  @JsonKey(
    fromJson: Utility.parseInt,
    toJson: Utility.int2Str
  )
  final int added_by;

  @observable
  @JsonKey(
    fromJson: Utility.parseInt,
    toJson: Utility.int2Str
  )
  int likes;

  @JsonKey(
    fromJson: Utility.parseInt,
    toJson: Utility.int2Str
  )
  int views;
  //try. if not stick to int
  @JsonKey(
    fromJson: Utility.parseBool,
    toJson: Utility.bool2int
  )
  @observable
  bool my_like;
  final String? hashtag;
  final UserModel? posted_by;

  final List<CommentModel>? comments;

  final List<MentionDataModel> mentions;

  final List<_PostImageModel> images;

  _PostModel({
    required this.image,
    required this.caption,
    required this.hypertext,
    required this.hyperlink,
    required this.created_at,
    required this.id,
    required this.chat_enabled,
    required this.added_by,
    required this.likes,
    required this.my_like,
    required this.views,
    this.hashtag,
    this.posted_by,
    required this.comments,
    this.mentions = const [],
    this.images = const []
  });

}


@JsonSerializable()
class _PostImageModel {
  @JsonKey(
    fromJson: Utility.parseImageUrl
  )
  final String image;
  @JsonKey(
    fromJson: Utility.parseInt,
    toJson: Utility.int2Str
  )
  final int index;
  _PostImageModel({
    required this.image,
    required this.index
  });
  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory _PostImageModel.fromJson(Map<String, dynamic> json) => _$PostImageModelFromJson(json);

  /// Connect the generated [_$_PostImageModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostImageModelToJson(this);
}