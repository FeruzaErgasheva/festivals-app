import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  final Function(LatLng) onLocationSelected;
  
  const GoogleMapPage({super.key, required this.onLocationSelected});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController myController;
  LatLng _currentPosition = LatLng(41.2856806, 69.2034646);
  Set<Marker> myMarkers = {};
  Set<Polyline> polylines = {};
  List<LatLng> positions = [];

  void _onMapCreated(GoogleMapController googleMapController) {
    myController = googleMapController;
  }

  void onCameraMove(CameraPosition position) {
    setState(() {
      _currentPosition = position.target;
      widget.onLocationSelected(_currentPosition);
    });
  }

  void addLocationMarker() {
    setState(() {
      myMarkers.add(
        Marker(
          markerId: MarkerId(myMarkers.length.toString()),
          position: _currentPosition,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          polylines: polylines,
          myLocationButtonEnabled: true,
          onCameraMove: onCameraMove,
          markers: {
            Marker(
              position: _currentPosition,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue,
              ),
              infoWindow: const InfoWindow(
                title: "Current Position",
                snippet: "Hozirgi joylashuv",
              ),
              markerId: const MarkerId("_currentPosition"),
            ),
            ...myMarkers
          },
          mapType: MapType.normal,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _currentPosition,
            zoom: 16,
          ),
        ),
      ],
    );
  }
}

