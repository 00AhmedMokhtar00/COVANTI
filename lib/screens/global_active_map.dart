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
  var _mapType = [MapType.normal,MapType.satellite,MapType.hybrid];
  int index = 0;
  Widget Info = Container(
    color: Colors.transparent,
  );
  Future start_map;
  @override
  void initState() {
    // start_map = _onMapCreated(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        backgroundColor: Colors.black.withOpacity(0.5),
        child: Icon(Icons.remove_red_eye, size: 30,),
        onPressed: (){
        setState(() {
          if(index == 2)
            index = 0;
          else
            index++;
        });
      },),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onTap: (loc){
              setState(() {
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
    setState(() {
      _markers.clear();
      for (final country in AllCountries.countries) {
        final marker = Marker(
          onTap: () {
            setState(() {
              Info = Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30)),
                  child: CasesBuilder(
                      int.parse(country.cases),
                      int.parse(country.deaths),
                      int.parse(country.recovered),
                      DateFormat.yMMMd().format(DateTime.now()) +
                          ' ' +
                          DateFormat.Hm().format(DateTime.now())));
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
    });
  }
}
