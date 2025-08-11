import 'package:json_annotation/json_annotation.dart';

part 'developer_dto.g.dart';

@JsonSerializable()
class DeveloperDTO {
  late final int id;
  late final String developerName;

  DeveloperDTO(this.developerName);

  Map<String, dynamic> toJson() => _$DeveloperDTOToJson(this);

  factory DeveloperDTO.fromJson(Map<String, dynamic> json) => _$DeveloperDTOFromJson(json);

  @override
  String toString() {
    return 'DeveloperDTO{id: $id, developerName: $developerName}';
  }
}
