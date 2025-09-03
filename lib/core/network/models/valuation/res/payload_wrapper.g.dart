// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayloadWrapper _$PayloadWrapperFromJson(Map<String, dynamic> json) =>
    PayloadWrapper()
      ..compsPayload = ValuationCompsPayloadDTO.fromJson(
        json['comps_payload'] as Map<String, dynamic>,
      );

Map<String, dynamic> _$PayloadWrapperToJson(PayloadWrapper instance) =>
    <String, dynamic>{'comps_payload': instance.compsPayload};
