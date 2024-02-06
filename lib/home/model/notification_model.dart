import 'package:json_annotation/json_annotation.dart';
import 'package:mewtwo/home/model/post_model.dart';
import 'package:mewtwo/home/model/user_model.dart';
part 'notification_model.g.dart';

enum NotificationType { comment, like, follow, mention, unknown }

@JsonSerializable(explicitToJson: true)
class NotificationModel {
  @JsonKey(
    fromJson: getNotificationType,
  )
  final NotificationType notification_type;

  final PostModel? postData;

  final UserModel userData;

  final String id, user_id, post_id, content, sent_by, created_at;

  NotificationModel(this.id, this.user_id, this.post_id, this.content, this.sent_by, this.created_at,
      {required this.notification_type, this.postData, required this.userData});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);

  /// Connect the generated [_$NotificationModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  static NotificationType getNotificationType(String type) {
    return NotificationType.values.map((e) => e.name).contains(type) ? NotificationType.values.byName(type) : NotificationType.unknown;
  }
}
