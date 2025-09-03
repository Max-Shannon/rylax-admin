import 'package:json_annotation/json_annotation.dart';

part 'rylax_property_valuation_request.g.dart';

@JsonSerializable()
class RylaxPropertyValuationRequest {
  late final int beds;
  late final int baths;
  late final String energyRating;
  late final double sqm;
  late final int approxBuildYear;
  late final double plotSize;
  late final String locationTown;
  late final String locationCounty;
  late final List<String> features;
  late final String finishLevel;
  late final String propertyStyle;

  Map<String, dynamic> toJson() => _$RylaxPropertyValuationRequestToJson(this);

  @override
  String toString() {
    return 'RylaxPropertyValuationRequest{beds: $beds, baths: $baths, energyRating: $energyRating, sqm: $sqm, approxBuildYear: $approxBuildYear, plotSize: $plotSize, locationTown: $locationTown, locationCounty: $locationCounty, features: $features, finishLevel: $finishLevel}';
  }


}
