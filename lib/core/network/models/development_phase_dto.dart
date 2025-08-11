import 'package:json_annotation/json_annotation.dart';
import 'package:rylax_admin/core/network/models/property_dto.dart';

part 'development_phase_dto.g.dart';

@JsonSerializable()
class DevelopmentPhaseDTO {
  late final int id;
  late final String phaseName;
  late final int phaseNumber;
  late final List<PropertyDTO> properties;

  DevelopmentPhaseDTO(this.id, this.phaseName, this.phaseNumber, this.properties);

  Map<String, dynamic> toJson() => _$DevelopmentPhaseDTOToJson(this);

  factory DevelopmentPhaseDTO.fromJson(Map<String, dynamic> json) => _$DevelopmentPhaseDTOFromJson(json);

  @override
  String toString() {
    return 'DevelopmentPhaseDTO{id: $id, phaseName: $phaseName, phaseNumber: $phaseNumber, properties: $properties}';
  }
}
