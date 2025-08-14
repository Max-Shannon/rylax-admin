// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyDTO _$PropertyDTOFromJson(Map<String, dynamic> json) => PropertyDTO(
  (json['id'] as num).toInt(),
  (json['assignedBuyerId'] as num).toInt(),
  json['propertyType'] as String,
  json['propertyStyle'] as String,
  json['unitType'] as String,
  json['buildStatus'] as String,
  json['saleStatus'] as String,
  (json['beds'] as num).toInt(),
  (json['baths'] as num).toInt(),
  (json['sqm'] as num).toInt(),
  (json['price'] as num).toInt(),
);

Map<String, dynamic> _$PropertyDTOToJson(PropertyDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'assignedBuyerId': instance.assignedBuyerId,
      'propertyType': instance.propertyType,
      'propertyStyle': instance.propertyStyle,
      'unitType': instance.unitType,
      'buildStatus': instance.buildStatus,
      'saleStatus': instance.saleStatus,
      'beds': instance.beds,
      'baths': instance.baths,
      'sqm': instance.sqm,
      'price': instance.price,
    };
