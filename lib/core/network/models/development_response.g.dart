// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'development_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevelopmentResponse _$DevelopmentResponseFromJson(Map<String, dynamic> json) =>
    DevelopmentResponse(
      (json['developments'] as List<dynamic>)
          .map((e) => DevelopmentDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DevelopmentResponseToJson(
  DevelopmentResponse instance,
) => <String, dynamic>{'developments': instance.developments};
