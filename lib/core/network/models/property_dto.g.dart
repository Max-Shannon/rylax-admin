// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyDTO _$PropertyDTOFromJson(Map<String, dynamic> json) =>
    PropertyDTO(json['propertyType'] as String)
      ..id = (json['id'] as num).toInt();

Map<String, dynamic> _$PropertyDTOToJson(PropertyDTO instance) =>
    <String, dynamic>{'id': instance.id, 'propertyType': instance.propertyType};
