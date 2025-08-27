import 'package:json_annotation/json_annotation.dart';

part 'property_dto.g.dart';

@JsonSerializable()
class PropertyDTO {
  late final int id;
  late final int? assignedBuyerId;
  late final String propertyType;
  late final String propertyStyle;
  late final String unitType;
  late final String buildStatus;
  late final String saleStatus;
  late final int beds;
  late final int baths;
  late final int sqm;
  late final int price;

  PropertyDTO(this.id, this.assignedBuyerId, this.propertyType, this.propertyStyle, this.unitType, this.buildStatus, this.saleStatus,
      this.beds, this.baths, this.sqm, this.price);

  Map<String, dynamic> toJson() => _$PropertyDTOToJson(this);

  factory PropertyDTO.fromJson(Map<String, dynamic> json) => _$PropertyDTOFromJson(json);



}