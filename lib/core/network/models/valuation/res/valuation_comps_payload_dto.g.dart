// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valuation_comps_payload_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValuationCompsPayloadDTO _$ValuationCompsPayloadDTOFromJson(
  Map<String, dynamic> json,
) => ValuationCompsPayloadDTO()
  ..subject = SubjectDTO.fromJson(json['subject'] as Map<String, dynamic>)
  ..marketWindowMonths = (json['market_window_months'] as num).toInt()
  ..searchRadiusKm = (json['search_radius_km'] as num).toDouble()
  ..comps =
      (json['comps'] as List<dynamic>?)
          ?.map((e) => CompDTO.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..summary = SummaryDTO.fromJson(json['summary'] as Map<String, dynamic>);

Map<String, dynamic> _$ValuationCompsPayloadDTOToJson(
  ValuationCompsPayloadDTO instance,
) => <String, dynamic>{
  'subject': instance.subject.toJson(),
  'market_window_months': instance.marketWindowMonths,
  'search_radius_km': instance.searchRadiusKm,
  'comps': instance.comps.map((e) => e.toJson()).toList(),
  'summary': instance.summary.toJson(),
};
