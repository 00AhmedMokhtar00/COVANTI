import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class HomeMap extends StatefulWidget {
  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  GoogleMapController mapController;
  Position position;
  Future _center;

  @override
  void initState() {
    _center = getCurrentLocation();
    super.initState();
  }
  void _onMapCreated(GoogleMapController controller) async{
    mapController = controller;
  }

  Future<LatLng> getCurrentLocation()async{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    final cur = LatLng(position.latitude, position.longitude);
    return cur;
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
      child: FutureBuilder(
        future: _center,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return GoogleMap(
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: snapshot.data,
                zoom: 4.0,
              ),
              markers: {_createMarker(snapshot.data)},
            );
          }else if(snapshot.hasError){
            return Text('Please enable location', style: Theme.of(context).textTheme.headline1,);
          }
          return Center(child: CircularProgressIndicator());
        }
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
