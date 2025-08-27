import 'package:json_annotation/json_annotation.dart';

part 'create_property_request.g.dart';

@JsonSerializable()
class CreatePropertyRequest {
  late final String propertyType;
  late final String propertyStyle;
  late final String unitType;
  late final int unitCount;
  late final int beds;
  late final int baths;
  late final int sqm;
  late final int price;

  CreatePropertyRequest(this.propertyType, this.propertyStyle, this.unitType, this.unitCount, this.beds, this.baths, this.sqm, this.price);

  Map<String, dynamic> toJson() => _$CreatePropertyRequestToJson(this);

}
