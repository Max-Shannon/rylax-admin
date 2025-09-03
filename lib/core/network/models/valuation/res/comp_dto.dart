import 'package:json_annotation/json_annotation.dart';

import 'adjustment_dto.dart';

part 'comp_dto.g.dart';

@JsonSerializable()
class CompDTO {
  late final String status; // "active" | "sold"
  late final String source; // "myhome.ie", "daft.ie", etc.
  late final String url;
  late final String title;
  late final String address;

  double? lat;
  double? lon;

  @JsonKey(name: 'distance_km')
  double? distanceKm;

  int? beds;
  int? baths;
  int? sqm;
  String? ber;

  @JsonKey(name: 'year_built')
  int? yearBuilt;

  @JsonKey(name: 'site_area')
  double? siteArea;

  @JsonKey(name: 'list_price_eur')
  int? listPriceEur;

  @JsonKey(name: 'sold_price_eur')
  int? soldPriceEur;

  @JsonKey(name: 'price_per_sqm_eur')
  double? pricePerSqmEur;

  @JsonKey(name: 'date_listed')
  DateTime? dateListed; // Expecting yyyy-MM-dd

  @JsonKey(name: 'date_sold')
  DateTime? dateSold; // Expecting yyyy-MM-dd

  String? agent;

  @JsonKey(defaultValue: <String>[])
  List<String>? images;

  @JsonKey(defaultValue: <String>[])
  List<String>? features;

  String? condition; // e.g. "turnkey", "good", "needs modernisation"
  String? notes;

  @JsonKey(name: 'similarity_score')
  double? similarityScore; // 0..1

  AdjustmentsDTO? adjustments;

  @JsonKey(name: 'adjusted_value_eur')
  int? adjustedValueEur;

  CompDTO();

  factory CompDTO.fromJson(Map<String, dynamic> json) => _$CompDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CompDTOToJson(this);

  @override
  String toString() {
    return 'CompDTO{status: $status, source: $source, url: $url, title: $title, address: $address, lat: $lat, lon: $lon, distanceKm: $distanceKm, beds: $beds, baths: $baths, sqm: $sqm, ber: $ber, yearBuilt: $yearBuilt, siteArea: $siteArea, listPriceEur: $listPriceEur, soldPriceEur: $soldPriceEur, pricePerSqmEur: $pricePerSqmEur, dateListed: $dateListed, dateSold: $dateSold, agent: $agent, images: $images, features: $features, condition: $condition, notes: $notes, similarityScore: $similarityScore, adjustments: $adjustments, adjustedValueEur: $adjustedValueEur}';
  }
}
