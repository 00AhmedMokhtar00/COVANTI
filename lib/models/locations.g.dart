// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatLng _$LatLngFromJson(Map<String, dynamic> json) {
  return LatLng(
      lat: (json['lat'] as num)?.toDouble(),
      lng: (json['lng'] as num)?.toDouble());
}

Map<String, dynamic> _$LatLngToJson(LatLng instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};



AllCountries _$OfficeFromJson(Map<String, dynamic> json) {
  return AllCountries(
      lat: double.parse(json['coordinates']['latitude'] as String),
      lng: double.parse(json['coordinates']['longitude'] as String),
      name: json['country'] as String,
      cases: (json['latest']['confirmed'] as num).toString(),
      deaths: (json['latest']['deaths'] as num).toString(),
      recovered: (json['latest']['recovered'] as num).toString()
  );
}

Map<String, dynamic> _$OfficeToJson(AllCountries instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'cases': instance.cases,
      'deaths': instance.deaths,
      'recovered': instance.recovered
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) {
  return Locations(
      countries: (json['locations'] as List)
          ?.map((e) =>
              e == null ? null : AllCountries.fromJson(e as Map<String, dynamic>))
          ?.toList(),
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) =>
    <String, dynamic>{'locations': instance.countries};
