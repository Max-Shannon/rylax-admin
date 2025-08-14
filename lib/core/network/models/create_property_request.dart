import 'package:json_annotation/json_annotation.dart';

part 'create_property_request.g.dart';

@JsonSerializable()
class CreatePropertyRequest {
  late final String propertyType;

  CreatePropertyRequest(this.propertyType);

  Map<String, dynamic> toJson() => _$CreatePropertyRequestToJson(this);

}
