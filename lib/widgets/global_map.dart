import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:solution_challenge/prefs/pref_manager.dart';

import '../screens/global_active_map.dart';


class GlobalMap extends StatelessWidget {
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
                  zoomGesturesEnabled: true,
                  onTap: (_){Navigator.pushNamed(context, GlobalActiveMap.routeName);},
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: PrefManager.current_location,
                    zoom: 0,
                  ),
        )
    );
  }
}