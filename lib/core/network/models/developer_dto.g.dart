// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeveloperDTO _$DeveloperDTOFromJson(Map<String, dynamic> json) =>
    DeveloperDTO(json['developerName'] as String)
      ..id = (json['id'] as num).toInt();

Map<String, dynamic> _$DeveloperDTOToJson(DeveloperDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'developerName': instance.developerName,
    };
