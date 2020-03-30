import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../screens/global_active_map.dart';


class GlobalMap extends StatelessWidget {
  GoogleMapController mapController;
  final LatLng cur_location;
  Position position;

  GlobalMap(this.cur_location);

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
        child: GoogleMap(
                  zoomGesturesEnabled: true,
                  onTap: (_){Navigator.of(context).push(MaterialPageRoute(builder: (_)=> GlobalActiveMap()));},
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: cur_location,
                    zoom: 0,
                  ),
        )
    );
  }
}

/*
*
* image: DecorationImage(
              image: ExactAssetImage('assets/images/hmap.png'),
              fit: BoxFit.fill
          )
* */


