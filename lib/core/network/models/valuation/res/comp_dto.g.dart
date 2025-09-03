// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comp_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompDTO _$CompDTOFromJson(Map<String, dynamic> json) => CompDTO()
  ..status = json['status'] as String
  ..source = json['source'] as String
  ..url = json['url'] as String
  ..title = json['title'] as String
  ..address = json['address'] as String
  ..lat = (json['lat'] as num?)?.toDouble()
  ..lon = (json['lon'] as num?)?.toDouble()
  ..distanceKm = (json['distance_km'] as num?)?.toDouble()
  ..beds = (json['beds'] as num?)?.toInt()
  ..baths = (json['baths'] as num?)?.toInt()
  ..sqm = (json['sqm'] as num?)?.toInt()
  ..ber = json['ber'] as String?
  ..yearBuilt = (json['year_built'] as num?)?.toInt()
  ..siteArea = (json['site_area'] as num?)?.toDouble()
  ..listPriceEur = (json['list_price_eur'] as num?)?.toInt()
  ..soldPriceEur = (json['sold_price_eur'] as num?)?.toInt()
  ..pricePerSqmEur = (json['price_per_sqm_eur'] as num?)?.toDouble()
  ..dateListed = json['date_listed'] == null
      ? null
      : DateTime.parse(json['date_listed'] as String)
  ..dateSold = json['date_sold'] == null
      ? null
      : DateTime.parse(json['date_sold'] as String)
  ..agent = json['agent'] as String?
  ..images =
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? []
  ..features =
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      []
  ..condition = json['condition'] as String?
  ..notes = json['notes'] as String?
  ..similarityScore = (json['similarity_score'] as num?)?.toDouble()
  ..adjustments = json['adjustments'] == null
      ? null
      : AdjustmentsDTO.fromJson(json['adjustments'] as Map<String, dynamic>)
  ..adjustedValueEur = (json['adjusted_value_eur'] as num?)?.toInt();

Map<String, dynamic> _$CompDTOToJson(CompDTO instance) => <String, dynamic>{
  'status': instance.status,
  'source': instance.source,
  'url': instance.url,
  'title': instance.title,
  'address': instance.address,
  'lat': instance.lat,
  'lon': instance.lon,
  'distance_km': instance.distanceKm,
  'beds': instance.beds,
  'baths': instance.baths,
  'sqm': instance.sqm,
  'ber': instance.ber,
  'year_built': instance.yearBuilt,
  'site_area': instance.siteArea,
  'list_price_eur': instance.listPriceEur,
  'sold_price_eur': instance.soldPriceEur,
  'price_per_sqm_eur': instance.pricePerSqmEur,
  'date_listed': instance.dateListed?.toIso8601String(),
  'date_sold': instance.dateSold?.toIso8601String(),
  'agent': instance.agent,
  'images': instance.images,
  'features': instance.features,
  'condition': instance.condition,
  'notes': instance.notes,
  'similarity_score': instance.similarityScore,
  'adjustments': instance.adjustments,
  'adjusted_value_eur': instance.adjustedValueEur,
};
