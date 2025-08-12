// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_development_phase_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDevelopmentPhaseRequest _$CreateDevelopmentPhaseRequestFromJson(
  Map<String, dynamic> json,
) => CreateDevelopmentPhaseRequest(
  json['phaseName'] as String,
  json['phaseNumber'] as String,
  DateTime.parse(json['phaseEstimatedStartDate'] as String),
  DateTime.parse(json['phaseEstimatedEndDate'] as String),
);

Map<String, dynamic> _$CreateDevelopmentPhaseRequestToJson(
  CreateDevelopmentPhaseRequest instance,
) => <String, dynamic>{
  'phaseName': instance.phaseName,
  'phaseNumber': instance.phaseNumber,
  'phaseEstimatedStartDate': instance.phaseEstimatedStartDate.toIso8601String(),
  'phaseEstimatedEndDate': instance.phaseEstimatedEndDate.toIso8601String(),
};
