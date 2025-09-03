import 'package:json_annotation/json_annotation.dart';
import 'package:rylax_admin/core/network/models/valuation/res/subject_dto.dart';
import 'package:rylax_admin/core/network/models/valuation/res/summary_dto.dart';

import 'comp_dto.dart';

part 'valuation_comps_payload_dto.g.dart';

/// Root payload for valuation comps.
@JsonSerializable(explicitToJson: true)
class ValuationCompsPayloadDTO {
  late final SubjectDTO subject;
  @JsonKey(name: 'market_window_months')
  late final int marketWindowMonths;
  @JsonKey(name: 'search_radius_km')
  late final double searchRadiusKm;
  @JsonKey(defaultValue: <CompDTO>[])
  late final List<CompDTO> comps;
  late final SummaryDTO summary;

  ValuationCompsPayloadDTO();

  factory ValuationCompsPayloadDTO.fromJson(Map<String, dynamic> json) => _$ValuationCompsPayloadDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ValuationCompsPayloadDTOToJson(this);

  @override
  String toString() =>
      'ValuationCompsPayloadDTO{marketWindowMonths: $marketWindowMonths, searchRadiusKm: $searchRadiusKm, comps: ${comps.length}}';
}