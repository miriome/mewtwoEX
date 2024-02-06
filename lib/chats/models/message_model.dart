import 'package:json_annotation/json_annotation.dart';
import 'package:mewtwo/utils.dart';
part 'message_model.g.dart';

// enum MessageType: String, Codable {
//   case day, text, image
// }

// struct MessageModel: Codable {
//     var sender_id, receiver_id: Int
//     var message: String
//     var content_type: MessageType
//     var time: TimeInterval
    
//     init() {
//         sender_id       = 0
//         receiver_id     = 0
//         message         = ""
//         content_type    = .day
//         time            = Date().timeIntervalSinceNow
//     }
// }

@JsonSerializable(explicitToJson: true)
class MessageModel {
  
  final int sender_id;
  final int receiver_id;

  final String message;

  final String content_type;
  
  final double time;
  

  MessageModel(this.sender_id, this.receiver_id, this.message, this.content_type, this.time);

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

  /// Connect the generated [_$MessageModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
