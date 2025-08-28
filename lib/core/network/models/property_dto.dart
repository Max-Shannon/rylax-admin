import 'package:json_annotation/json_annotation.dart';

part 'property_dto.g.dart';

@JsonSerializable()
class PropertyDTO {
  late final int id;
  late final int? assignedBuyerId;
  late final String propertyType;
  late final String propertyStyle;
  late final String unitType;
  late String buildStatus;
  late String saleStatus;
  late final int beds;
  late final int baths;
  late final int sqm;
  late final int price;

  PropertyDTO(this.id, this.assignedBuyerId, this.propertyType, this.propertyStyle, this.unitType, this.buildStatus, this.saleStatus,
      this.beds, this.baths, this.sqm, this.price);

  Map<String, dynamic> toJson() => _$PropertyDTOToJson(this);

  factory PropertyDTO.fromJson(Map<String, dynamic> json) => _$PropertyDTOFromJson(json);

  @override
  String toString() {
    return 'PropertyDTO{id: $id, assignedBuyerId: $assignedBuyerId, propertyType: $propertyType, propertyStyle: $propertyStyle, unitType: $unitType, buildStatus: $buildStatus, saleStatus: $saleStatus, beds: $beds, baths: $baths, sqm: $sqm, price: $price}';
  }


}