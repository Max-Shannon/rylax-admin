// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rylax_property_valuation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RylaxPropertyValuationRequest _$RylaxPropertyValuationRequestFromJson(
  Map<String, dynamic> json,
) => RylaxPropertyValuationRequest()
  ..beds = (json['beds'] as num).toInt()
  ..baths = (json['baths'] as num).toInt()
  ..energyRating = json['energyRating'] as String
  ..sqm = (json['sqm'] as num).toDouble()
  ..approxBuildYear = (json['approxBuildYear'] as num).toInt()
  ..plotSize = (json['plotSize'] as num).toDouble()
  ..locationTown = json['locationTown'] as String
  ..locationCounty = json['locationCounty'] as String
  ..features = (json['features'] as List<dynamic>)
      .map((e) => e as String)
      .toList()
  ..finishLevel = json['finishLevel'] as String;

Map<String, dynamic> _$RylaxPropertyValuationRequestToJson(
  RylaxPropertyValuationRequest instance,
) => <String, dynamic>{
  'beds': instance.beds,
  'baths': instance.baths,
  'energyRating': instance.energyRating,
  'sqm': instance.sqm,
  'approxBuildYear': instance.approxBuildYear,
  'plotSize': instance.plotSize,
  'locationTown': instance.locationTown,
  'locationCounty': instance.locationCounty,
  'features': instance.features,
  'finishLevel': instance.finishLevel,
};
