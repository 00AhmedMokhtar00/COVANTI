import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/cases_builder.dart';
import '../models/locations.dart' as locations;


class GlobalActiveMap extends StatefulWidget {
  @override
  _GlobalActiveMapState createState() => _GlobalActiveMapState();
}

class _GlobalActiveMapState extends State<GlobalActiveMap> {
  GoogleMapController controller;
  final Map<String, Marker> _markers = {};
  Widget Info = Container(color: Colors.transparent,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder<void>(
            future: _onMapCreated(controller),
            builder: (context, snapshot) {
                return GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: const LatLng(0, 0),
                    zoom: 0,
                  ),
                  markers: _markers.values.toSet(),
                );

            }
          ),
          Container(margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),child: BackButton(onPressed: (){Navigator.pop(context);},color: Colors.blue,)),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.transparent,
              width: double.infinity,
              height: 200,
              child: Info),
          ),
        ],
      ),
    );
  }


  Future<void> _onMapCreated(GoogleMapController controller) async {
    final AllCountries = await locations.getAllCountries();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final casesUS =  prefs.getInt('casesUSA');
    final deathsUS =  prefs.getInt('deathsUSA');
    final recoveredUS =  prefs.getInt('recoveredUSA');
    setState(() {
      _markers.clear();
      _markers['United States'] = Marker(
        onTap: (){
          setState(() {
            Info = Container(decoration: BoxDecoration(
                color:Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30)
            ),child: CasesBuilder(casesUS, deathsUS, recoveredUS, DateFormat.yMMMd().format(DateTime.now()) + ' ' + DateFormat.Hm().format(DateTime.now())));
          });
        },
        markerId: MarkerId('United States'),
        position: LatLng(39.381266, -97.922211),
        infoWindow: InfoWindow(
          title: 'United States',
        ),
      );
      for (final country in AllCountries.countries) {
        final marker = Marker(
          onTap: (){
            setState(() {
              Info = Container(decoration: BoxDecoration(
                  color:Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(30)
              ),child: CasesBuilder(int.parse(country.cases), int.parse(country.deaths), int.parse(country.recovered), DateFormat.yMMMd().format(DateTime.now()) + ' ' + DateFormat.Hm().format(DateTime.now())));
            });
          },
          markerId: MarkerId(country.name),
          position: LatLng(country.lat, country.lng),
          infoWindow: InfoWindow(
            title: country.name,
          ),
        );
        _markers[country.name] = marker;
      }
    });
  }

}
