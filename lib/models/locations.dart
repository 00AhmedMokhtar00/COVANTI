import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import '../res/assets.dart';

part 'locations.g.dart';

@JsonSerializable()
class LatLng {
  LatLng({
    this.lat,
    this.lng,
  });

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);

  final double lat;
  final double lng;
}

@JsonSerializable()
class AllCountries {
  AllCountries({
    this.cases,
    this.deaths,
    this.recovered,
    this.todayDeaths,
    this.todayCases,
    this.lat,
    this.lng,
    this.name,
  });

  factory AllCountries.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);

  final double lat;
  final double lng;
  final String name;
  final String cases;
  final String deaths;
  final String recovered;
  final String todayCases;
  final String todayDeaths;
}

@JsonSerializable()
class Locations {
  Locations({
    this.countries,
  });

  factory Locations.fromJson(List<dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<AllCountries> countries;
}

Future<Locations> getAllCountries() async {

  final response = await http.get(Links.CORONA_CASES);
  if (response.statusCode == 200) {
    return Locations.fromJson(json.decode(response.body));
  } else {
    throw HttpException(
        'Unexpected status code ${response.statusCode}:'
            ' ${response.reasonPhrase}',
        uri: Uri.parse(Links.CORONA_CASES));
  }
}