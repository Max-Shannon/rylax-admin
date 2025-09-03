import 'package:json_annotation/json_annotation.dart';
import 'package:rylax_admin/core/network/models/valuation/res/valuation_comps_payload_dto.dart';

part 'payload_wrapper.g.dart';

@JsonSerializable()
class PayloadWrapper {
  @JsonKey(name: 'comps_payload')
  late final ValuationCompsPayloadDTO compsPayload;

  PayloadWrapper();

  factory PayloadWrapper.fromJson(Map<String, dynamic> json) => _$PayloadWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PayloadWrapperToJson(this);

  @override
  String toString() {
    return 'PayloadWrapper{compsPayload: $compsPayload}';
  }
}
