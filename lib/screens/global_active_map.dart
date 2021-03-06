import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../prefs/pref_manager.dart';
import '../widgets/cases_builder.dart';
import '../models/locations.dart' as locations;

class GlobalActiveMap extends StatefulWidget {
  static const String routeName = "GlobalActiveMap";
  @override
  _GlobalActiveMapState createState() => _GlobalActiveMapState();
}

class _GlobalActiveMapState extends State<GlobalActiveMap> {
  bool isLoading = false;
  GoogleMapController controller;
  final Map<String, Marker> _markers = {};
  var _mapType = [MapType.normal,MapType.satellite,MapType.hybrid];
  int index = 0;
  bool isMarkerClicked = false;
  Widget Info = Container(
    color: Colors.transparent,
  );
  Future start_map;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 100),
        child: FloatingActionButton(
          elevation: 5,
          backgroundColor: Colors.black.withOpacity(0.5),
          child: Icon(Icons.remove_red_eye, size: 30, color: Colors.white,),
          onPressed: (){
          setState(() {
            if(index == 2) {
              index = 0;
            }
            else {
              index++;
            }
          });
        },),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (loc){
              setState(() {
                isMarkerClicked = false;
                Info = Container(
                  color: Colors.transparent,
                );
              });
            },
            mapType: _mapType[index],
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: const LatLng(0, 0),
              zoom: 0,
            ),
            markers: _markers.values.toSet(),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(50)),
              child: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              )),
          isMarkerClicked?Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                color: Colors.transparent,
                width: double.infinity,
                //height: 200.0,
                child: Info),
          ):Container(),
          isLoading?Center(child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColor,)):Container()
        ],
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {isLoading = true;});
    final AllCountries = await locations.getAllCountries();
    setState(() {
      _markers.clear();
      for (final country in AllCountries.countries) {
        final marker = Marker(
          onTap: () {
            isMarkerClicked = true;
            setState(() {
              Info = Container(
                  height: MediaQuery.of(context).size.height * 0.27,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30)),
                  child: CasesBuilder(
                      int.parse(country.cases),
                      int.parse(country.deaths),
                      int.parse(country.recovered),
                      int.parse(country.todayCases),
                      int.parse(country.todayDeaths),
                      PrefManager.lastUpdate,
                      ctx: context
                  )
              );
            });
          },
          markerId: MarkerId(country.name),
          position: country.name != 'USA'
              ? LatLng(country.lat, country.lng)
              : LatLng(39.381266, -97.922211),
          infoWindow: InfoWindow(
            title: country.name,
          ),
        );
        _markers[country.name] = marker;
      }
      isLoading = false;
    });
  }
}
