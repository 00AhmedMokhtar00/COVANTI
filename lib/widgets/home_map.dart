import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solution_challenge/prefs/pref_manager.dart';


class HomeMap extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final MQ = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: MQ * 0.26,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
      ),
      child: GoogleMap(
        onTap: (v){},
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        onMapCreated: null,
        initialCameraPosition: CameraPosition(
          target: PrefManager.current_location,
          zoom: 4.0,
        ),
        markers: {_createMarker(PrefManager.current_location)},
      )
    );
  }
}

Marker _createMarker(LatLng pos) {
  return Marker(
      markerId: MarkerId("marker1"),
      position: pos,
      icon: BitmapDescriptor.defaultMarker,
    );
}