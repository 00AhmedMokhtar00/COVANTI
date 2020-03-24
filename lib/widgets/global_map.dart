import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../screens/global_active_map.dart';


class GlobalMap extends StatelessWidget {
  GoogleMapController mapController;
  Position position;
  Future _center;

  GlobalMap(){_center = getCurrentLocation();}

  Future<LatLng> getCurrentLocation()async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    final cur = LatLng(position.latitude, position.longitude);
    return cur;
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
            future: _center,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return GoogleMap(
                  zoomGesturesEnabled: true,
                  onTap: (_){Navigator.of(context).push(MaterialPageRoute(builder: (_)=> GlobalActiveMap()));},
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: snapshot.data,
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

/*
*
* image: DecorationImage(
              image: ExactAssetImage('assets/images/hmap.png'),
              fit: BoxFit.fill
          )
* */


