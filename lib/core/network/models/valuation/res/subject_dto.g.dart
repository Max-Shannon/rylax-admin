// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectDTO _$SubjectDTOFromJson(Map<String, dynamic> json) => SubjectDTO()
  ..addressHint = json['address_hint'] as String
  ..dwellingType = json['dwelling_type'] as String
  ..beds = (json['beds'] as num).toInt()
  ..baths = (json['baths'] as num).toInt()
  ..sqm = (json['sqm'] as num).toInt()
  ..ber = json['ber'] as String
  ..yearBuilt = (json['year_built'] as num).toInt()
  ..features =
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      []
  ..finishLevel = json['finish_level'] as String;

Map<String, dynamic> _$SubjectDTOToJson(SubjectDTO instance) =>
    <String, dynamic>{
      'address_hint': instance.addressHint,
      'dwelling_type': instance.dwellingType,
      'beds': instance.beds,
      'baths': instance.baths,
      'sqm': instance.sqm,
      'ber': instance.ber,
      'year_built': instance.yearBuilt,
      'features': instance.features,
      'finish_level': instance.finishLevel,
    };
