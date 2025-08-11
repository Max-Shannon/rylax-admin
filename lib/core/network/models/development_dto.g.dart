// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'development_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevelopmentDTO _$DevelopmentDTOFromJson(Map<String, dynamic> json) =>
    DevelopmentDTO()
      ..id = (json['id'] as num).toInt()
      ..developer = DeveloperDTO.fromJson(
        json['developer'] as Map<String, dynamic>,
      )
      ..developmentName = json['developmentName'] as String
      ..developmentLat = (json['developmentLat'] as num).toDouble()
      ..developmentLng = (json['developmentLng'] as num).toDouble()
      ..developmentPhases = (json['developmentPhases'] as List<dynamic>)
          .map((e) => DevelopmentPhaseDTO.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DevelopmentDTOToJson(DevelopmentDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'developer': instance.developer,
      'developmentName': instance.developmentName,
      'developmentLat': instance.developmentLat,
      'developmentLng': instance.developmentLng,
      'developmentPhases': instance.developmentPhases,
    };
