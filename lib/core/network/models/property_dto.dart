import 'package:json_annotation/json_annotation.dart';

part 'property_dto.g.dart';

@JsonSerializable()
class PropertyDTO {
  late final int id;
  late final String propertyType;

  PropertyDTO(this.propertyType);

  Map<String, dynamic> toJson() => _$PropertyDTOToJson(this);

  factory PropertyDTO.fromJson(Map<String, dynamic> json) => _$PropertyDTOFromJson(json);

}