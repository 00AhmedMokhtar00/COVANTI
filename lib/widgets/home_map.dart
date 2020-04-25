import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class HomeMap extends StatelessWidget {

  HomeMap(this.cur);

  GoogleMapController mapController;
  Position position;
  final LatLng cur;

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
      child: Image.network('https://maps.googleapis.com/maps/api/staticmap?center=&${cur.latitude},${cur.longitude}&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C${cur.latitude},${cur.longitude}&key=AIzaSyDScFkj7iFL-Ks9MNWVNrmKjOVrNDbnQo4')
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

/*
String generateLocationPreviewImage({double latitude, double longitude,}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
 */


/*
GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: cur,
                zoom: 4.0,
              ),
              markers: {_createMarker(cur)},
            )
 */