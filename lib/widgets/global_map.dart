import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class GlobalMap extends StatelessWidget {
  GoogleMapController mapController;
  Position position;
  LatLng _center;

  Future<LatLng> getCurrentLocation()async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    _center = LatLng(position.latitude, position.longitude);
    return _center;
  }

  @override
  Widget build(BuildContext context) {
    final MQ = MediaQuery.of(context).size.height;
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: MQ * 0.26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: FutureBuilder(
            future: getCurrentLocation(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 0,
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }
        )
    );
  }
}

Set<Marker> _createMarker(LatLng pos) {
  return <Marker>[
    Marker(
      markerId: MarkerId("marker_1"),
      position: pos,
      icon: BitmapDescriptor.defaultMarker,
    ),
  ].toSet();
}
/*
*
* image: DecorationImage(
              image: ExactAssetImage('assets/images/hmap.png'),
              fit: BoxFit.fill
          )
* */


