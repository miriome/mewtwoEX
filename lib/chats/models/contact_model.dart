import 'package:json_annotation/json_annotation.dart';
import 'package:mewtwo/home/model/user_model.dart';
import 'package:mewtwo/utils.dart';
part 'contact_model.g.dart';



@JsonSerializable(explicitToJson: true)
class ContactModel {
  @JsonKey(
    fromJson: Utility.parseInt,
    toJson: Utility.int2Str
  )
  final int id;

  @JsonKey(
    fromJson: Utility.parseInt,
    toJson: Utility.int2Str
  )
  final int target_id;
  

  final String last_message;
  @JsonKey(
    fromJson: Utility.parseInt,
    toJson: Utility.int2Str
  )
  final int last_timestamp;
  final String last_date;
  final UserModel contactUser;
  

  ContactModel(this.target_id, this.last_message, this.last_timestamp, this.last_date, this.contactUser, 
      {required this.id,
      });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);

  /// Connect the generated [_$ContactModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
