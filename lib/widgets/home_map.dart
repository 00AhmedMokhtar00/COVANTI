import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class HomeMap extends StatelessWidget {

  GoogleMapController mapController;
  Position position;
  Future _center;
  final LatLng cur;
  HomeMap(this.cur);

  void _onMapCreated(GoogleMapController controller) async{
    mapController = controller;
  }


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
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: cur,
                zoom: 4.0,
              ),
              markers: {_createMarker(cur)},
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
