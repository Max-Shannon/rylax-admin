import 'package:json_annotation/json_annotation.dart';

import 'development_dto.dart';

part 'development_response.g.dart';

@JsonSerializable()
class DevelopmentResponse {

  late List<DevelopmentDTO> developments;

  DevelopmentResponse(this.developments);

  Map<String, dynamic> toJson() => _$DevelopmentResponseToJson(this);

  factory DevelopmentResponse.fromJson(Map<String, dynamic> json) => _$DevelopmentResponseFromJson(json);

}