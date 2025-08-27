// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_property_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreatePropertyRequest _$CreatePropertyRequestFromJson(
  Map<String, dynamic> json,
) => CreatePropertyRequest(
  json['propertyType'] as String,
  json['propertyStyle'] as String,
  json['unitType'] as String,
  (json['unitCount'] as num).toInt(),
  (json['beds'] as num).toInt(),
  (json['baths'] as num).toInt(),
  (json['sqm'] as num).toInt(),
  (json['price'] as num).toInt(),
);

Map<String, dynamic> _$CreatePropertyRequestToJson(
  CreatePropertyRequest instance,
) => <String, dynamic>{
  'propertyType': instance.propertyType,
  'propertyStyle': instance.propertyStyle,
  'unitType': instance.unitType,
  'unitCount': instance.unitCount,
  'beds': instance.beds,
  'baths': instance.baths,
  'sqm': instance.sqm,
  'price': instance.price,
};
