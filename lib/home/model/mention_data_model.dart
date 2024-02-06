import 'package:json_annotation/json_annotation.dart';

import 'package:mewtwo/utils.dart';

part 'mention_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MentionDataModel {
  @JsonKey(
    fromJson: Utility.parseInt,
  )
  final int user_id;

  final String username;

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory MentionDataModel.fromJson(Map<String, dynamic> json) => _$MentionDataModelFromJson(json);

  MentionDataModel({
    required this.user_id,
    required this.username,
  });

  /// Connect the generated [_$MentionDataModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MentionDataModelToJson(this);
}
