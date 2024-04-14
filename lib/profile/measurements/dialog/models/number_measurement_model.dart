import 'package:json_annotation/json_annotation.dart';
import 'package:mewtwo/utils.dart';
part 'number_measurement_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NumberMeasurementModel {
  @JsonKey(fromJson: parseMeasurement,)
  final int? height;
  @JsonKey(
    fromJson: parseMeasurement,
  )
  final int? waist;
  @JsonKey(
    fromJson: parseMeasurement,
  )
  final int? hips;
  @JsonKey(
    fromJson: parseMeasurement,
  )
  final int? bust;

  NumberMeasurementModel({required this.height, required this.waist, required this.hips, required this.bust});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory NumberMeasurementModel.fromJson(Map<String, dynamic> json) => _$NumberMeasurementModelFromJson(json);

  /// Connect the generated [_$NumberMeasurementModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NumberMeasurementModelToJson(this);

  static int? parseMeasurement(String? measurement) {
    return measurement != null
                  ? (Utility.parseInt(measurement) > 0 ? Utility.parseInt(measurement) : null)
                  : null;

  }

  bool hasNoMeasurement() {
    return waist == null && height == null && hips == null && bust == null;
  }
}
