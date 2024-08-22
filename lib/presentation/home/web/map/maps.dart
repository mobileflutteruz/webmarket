import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMapPage extends StatefulWidget {
  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  static const _initialCameraPosition = CameraPosition(
    target:
        LatLng(37.427961, -122.085749), // Replace with your desired location
    zoom: 14.4746,
  );

  late GoogleMapController _googleMapController;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId('myMarker'),
      position:
          LatLng(37.427961, -122.085749), // Replace with your desired location
      infoWindow: InfoWindow(
        title: 'Hello, world!',
        snippet: 'This is a custom marker',
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialCameraPosition,
      onMapCreated: (GoogleMapController controller) {
        _googleMapController = controller;
      },
      markers: _markers,
    );
  }
}
