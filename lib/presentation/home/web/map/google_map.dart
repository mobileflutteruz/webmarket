import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapFlutter extends StatelessWidget {
  GoogleMapFlutter({super.key});
  LatLng myCurrentLocation = LatLng(27.7172, 85.3240);

  late GoogleMapController googleMapController;

  Set<Marker> marker = {};

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationButtonEnabled: false,
      markers: marker,
      onMapCreated: (GoogleMapController controller) {
        googleMapController = controller;
        
      },
      initialCameraPosition: CameraPosition(
        target: myCurrentLocation,
        zoom: 14,
      ),
    );
  }
}
