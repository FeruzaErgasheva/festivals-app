import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService {
  static final _location = Location();

  static bool _isServiceEnabled = false;
  static PermissionStatus _permissionStatus = PermissionStatus.denied;
  static LocationData currentLocation = LocationData.fromMap({});

  static Future<void> init() async {
    await _checkService();
    await _checkPermission();

    await _location.changeSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
      interval: 1000,
    );
  }

  // joylashuvni olish xizmati yoqilganmi tekshiramiz
  static Future<void> _checkService() async {
    _isServiceEnabled = await _location.serviceEnabled();

    if (!_isServiceEnabled) {
      _isServiceEnabled = await _location.requestService();
      if (!_isServiceEnabled) {
        return; // Redirect to Settings - Sozlamalardan to'g'irlash kerak endi
      }
    }
  }

  // joylashuvni olish uchun ruxsat berilganmi tekshiramiz
  static Future<void> _checkPermission() async {
    _permissionStatus = await _location.hasPermission();

    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) {
        return; // Sozlamalardan to'g'irlash kerak (ruxsat berish kerak)
      }
    }
  }

  // hozirgi joylashuvni olamiz
  static Future<LocationData> getCurrentLocation() async {
    if (_isServiceEnabled && _permissionStatus == PermissionStatus.granted) {
      currentLocation = await _location.getLocation();
      return currentLocation;
    }
    return currentLocation;
  }

  static Stream<LocationData> getLiveLocation() async* {
    yield* _location.onLocationChanged;
  }

  ///direction olish uchun
  static Future<List<LatLng>> fetchPolylinePoints(
    LatLng from,
    LatLng to,
  ) async {
    ///flutter polyline_points
    final polylinePoints = PolylinePoints();

    final result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: "AIzaSyBEjfX9jrWudgRcWl2scld4R7s0LtlaQmQ",
      request: PolylineRequest(
        origin: PointLatLng(from.latitude, from.longitude),
        destination: PointLatLng(to.latitude, to.longitude),
        mode: TravelMode.walking,
      ),
    );

    // result.

    // print(result.);

    if (result.points.isNotEmpty) {
      return result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    }

    return [];
  }
}