// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'development_phase_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevelopmentPhaseDTO _$DevelopmentPhaseDTOFromJson(Map<String, dynamic> json) =>
    DevelopmentPhaseDTO(
      (json['id'] as num).toInt(),
      json['phaseName'] as String,
      (json['phaseNumber'] as num).toInt(),
      (json['properties'] as List<dynamic>)
          .map((e) => PropertyDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DevelopmentPhaseDTOToJson(
  DevelopmentPhaseDTO instance,
) => <String, dynamic>{
  'id': instance.id,
  'phaseName': instance.phaseName,
  'phaseNumber': instance.phaseNumber,
  'properties': instance.properties,
};
