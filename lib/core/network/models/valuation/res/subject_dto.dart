import 'package:json_annotation/json_annotation.dart';

part 'subject_dto.g.dart';

@JsonSerializable()
class SubjectDTO {
  @JsonKey(name: 'address_hint')
  late final String addressHint;

  @JsonKey(name: 'dwelling_type')
  late final String dwellingType; // e.g. "semi-detached"

  late final int beds;
  late final int baths;
  late final int sqm;
  late final String ber; // e.g. "B2"

  @JsonKey(name: 'year_built')
  late final int yearBuilt;

  @JsonKey(defaultValue: <String>[])
  late final List<String> features; // e.g. ["two-story-duplex"]

  @JsonKey(name: 'finish_level')
  late final String finishLevel; // e.g. "modern"

  SubjectDTO();

  factory SubjectDTO.fromJson(Map<String, dynamic> json) => _$SubjectDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectDTOToJson(this);

  @override
  String toString() =>
      'SubjectDTO{addressHint: $addressHint, dwellingType: $dwellingType, beds: $beds, baths: $baths, sqm: $sqm, ber: $ber, yearBuilt: $yearBuilt}';
}
