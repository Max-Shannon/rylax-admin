// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryDTO _$SummaryDTOFromJson(Map<String, dynamic> json) => SummaryDTO()
  ..valuationPointEur = (json['valuation_point_eur'] as num).toInt()
  ..valuationLowEur = (json['valuation_low_eur'] as num).toInt()
  ..valuationHighEur = (json['valuation_high_eur'] as num).toInt()
  ..method = json['method'] as String
  ..dataConfidence0to1 = (json['data_confidence_0to1'] as num).toDouble()
  ..sourcesUsed =
      (json['sources_used'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      []
  ..disclaimers = json['disclaimers'] as String?;

Map<String, dynamic> _$SummaryDTOToJson(SummaryDTO instance) =>
    <String, dynamic>{
      'valuation_point_eur': instance.valuationPointEur,
      'valuation_low_eur': instance.valuationLowEur,
      'valuation_high_eur': instance.valuationHighEur,
      'method': instance.method,
      'data_confidence_0to1': instance.dataConfidence0to1,
      'sources_used': instance.sourcesUsed,
      'disclaimers': instance.disclaimers,
    };
