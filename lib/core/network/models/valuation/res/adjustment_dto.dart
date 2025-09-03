import 'package:json_annotation/json_annotation.dart';

part 'adjustment_dto.g.dart';

@JsonSerializable()
class AdjustmentsDTO {
  int? size; // EUR; may be negative
  int? ber; // EUR
  int? condition; // EUR
  @JsonKey(name: 'market_trend')
  int? marketTrend; // EUR
  int? other; // EUR

  AdjustmentsDTO();

  factory AdjustmentsDTO.fromJson(Map<String, dynamic> json) => _$AdjustmentsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$AdjustmentsDTOToJson(this);
}