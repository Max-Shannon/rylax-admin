import 'package:json_annotation/json_annotation.dart';

part 'summary_dto.g.dart';


@JsonSerializable()
class SummaryDTO {
  @JsonKey(name: 'valuation_point_eur')
  late final int valuationPointEur;
  @JsonKey(name: 'valuation_low_eur')
  late final int valuationLowEur;
  @JsonKey(name: 'valuation_high_eur')
  late final int valuationHighEur;
  late final String method; // e.g. "Weighted average: sold(0.6), active(0.4) ..."
  @JsonKey(name: 'data_confidence_0to1')
  late final double dataConfidence0to1;
  @JsonKey(name: 'sources_used', defaultValue: <String>[])
  late final List<String> sourcesUsed;
  String? disclaimers;

  SummaryDTO();

  factory SummaryDTO.fromJson(Map<String, dynamic> json) => _$SummaryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryDTOToJson(this);


  @override
  String toString() =>
      'SummaryDTO{valuationPointEur: $valuationPointEur, range: [$valuationLowEur, $valuationHighEur], confidence: $dataConfidence0to1}';
}