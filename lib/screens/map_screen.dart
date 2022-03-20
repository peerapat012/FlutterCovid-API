import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSCreen extends StatefulWidget {
  const MapSCreen({ Key? key }) : super(key: key);

  @override
  State<MapSCreen> createState() => _MapSCreenState();
}

class _MapSCreenState extends State<MapSCreen> {

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ตึก 17")),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(13.120371, 100.919530),
          zoom: 11.5,
        ),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}