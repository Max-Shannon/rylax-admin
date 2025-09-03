
import 'package:json_annotation/json_annotation.dart';
import 'package:rylax_admin/core/network/models/valuation/res/payload_wrapper.dart';

part 'rylax_valuation_response.g.dart';

@JsonSerializable()
class RylaxValuationResponse {
  late final String summary;
  late final PayloadWrapper payload;

  RylaxValuationResponse();

  factory RylaxValuationResponse.fromJson(Map<String, dynamic> json) => _$RylaxValuationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RylaxValuationResponseToJson(this);

  @override
  String toString() {
    return 'RylaxValuationResponse{summary: $summary, payload: $payload}';
  }
}