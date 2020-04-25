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
      lat: double.parse(json['countryInfo']['lat'].toString()),
      lng: double.parse(json['countryInfo']['long'].toString()),
      name: json['country'] as String,
      cases: (json['cases'] as num).toString(),
      deaths: (json['deaths'] as num).toString(),
      recovered: (json['recovered'] as num).toString(),
      todayCases: (json['todayCases'] as num).toString(),
      todayDeaths: (json['todayDeaths'] as num).toString(),
  );
}

Map<String, dynamic> _$OfficeToJson(AllCountries instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'cases': instance.cases,
      'deaths': instance.deaths,
      'recovered': instance.recovered,
      'todayCases': instance.todayCases,
      'todayDeaths': instance.todayDeaths
    };

Locations _$LocationsFromJson(List<dynamic> json) {
  return Locations(
      countries: (json as List)
          ?.map((e) =>
              e == null ? null : AllCountries.fromJson(e as Map<String, dynamic>))
          ?.toList(),
  );
}

Map<String, dynamic> _$LocationsToJson(Locations instance) =>
    <String, dynamic>{'locations': instance.countries};
