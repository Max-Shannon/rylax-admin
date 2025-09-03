// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adjustment_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdjustmentsDTO _$AdjustmentsDTOFromJson(Map<String, dynamic> json) =>
    AdjustmentsDTO()
      ..size = (json['size'] as num?)?.toInt()
      ..ber = (json['ber'] as num?)?.toInt()
      ..condition = (json['condition'] as num?)?.toInt()
      ..marketTrend = (json['market_trend'] as num?)?.toInt()
      ..other = (json['other'] as num?)?.toInt();

Map<String, dynamic> _$AdjustmentsDTOToJson(AdjustmentsDTO instance) =>
    <String, dynamic>{
      'size': instance.size,
      'ber': instance.ber,
      'condition': instance.condition,
      'market_trend': instance.marketTrend,
      'other': instance.other,
    };
