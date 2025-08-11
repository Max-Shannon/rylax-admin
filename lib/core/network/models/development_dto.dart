import 'package:json_annotation/json_annotation.dart';
import 'package:rylax_admin/core/network/models/developer_dto.dart';

import 'development_phase_dto.dart';

part 'development_dto.g.dart';

@JsonSerializable()
class DevelopmentDTO {
  late final int id;
  late final DeveloperDTO developer;
  late final String developmentName;
  late final double developmentLat;
  late final double developmentLng;
  late final List<DevelopmentPhaseDTO> developmentPhases;

  DevelopmentDTO();

  Map<String, dynamic> toJson() => _$DevelopmentDTOToJson(this);

  factory DevelopmentDTO.fromJson(Map<String, dynamic> json) => _$DevelopmentDTOFromJson(json);

  @override
  String toString() {
    return 'DevelopmentDTO{id: $id, developer: $developer, developmentName: $developmentName, developmentLat: $developmentLat, developmentLng: $developmentLng, developmentPhases: $developmentPhases}';
  }
}
