// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_measurement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NumberMeasurementModel _$NumberMeasurementModelFromJson(
        Map<String, dynamic> json) =>
    NumberMeasurementModel(
      height:
          NumberMeasurementModel.parseMeasurement(json['height'] as String?),
      waist: NumberMeasurementModel.parseMeasurement(json['waist'] as String?),
      hips: NumberMeasurementModel.parseMeasurement(json['hips'] as String?),
      bust: NumberMeasurementModel.parseMeasurement(json['bust'] as String?),
    );

Map<String, dynamic> _$NumberMeasurementModelToJson(
        NumberMeasurementModel instance) =>
    <String, dynamic>{
      'height': instance.height,
      'waist': instance.waist,
      'hips': instance.hips,
      'bust': instance.bust,
    };
