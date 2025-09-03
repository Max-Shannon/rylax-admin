// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rylax_valuation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RylaxValuationResponse _$RylaxValuationResponseFromJson(
  Map<String, dynamic> json,
) => RylaxValuationResponse()
  ..summary = json['summary'] as String
  ..payload = PayloadWrapper.fromJson(json['payload'] as Map<String, dynamic>);

Map<String, dynamic> _$RylaxValuationResponseToJson(
  RylaxValuationResponse instance,
) => <String, dynamic>{
  'summary': instance.summary,
  'payload': instance.payload,
};
