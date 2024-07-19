import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/services/festivals/festivals_http_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FestivalsRepositories {
  final FestivalsHttpServices _festivalsHttpServices;

  FestivalsRepositories({
    required FestivalsHttpServices festivalsHttpServices,
  }) : _festivalsHttpServices = festivalsHttpServices;

  Future<List<FestivalModel>> getFestivals() async {
    return await _festivalsHttpServices.getFestivals();
  }

  Future<List<FestivalModel>> getFestivalsWithinWeek() async {
    return await _festivalsHttpServices.getFestivalsWithinWeek();
  }

  Future<void> incrementAttendants(
    String id,
    int attendants,
  ) async {
    await _festivalsHttpServices.incrementAttendants(id, attendants);
  }

  Future<FestivalModel> addFestival(
      String name,
      String addedDate,
      String addedTime,
      String description,
      String imageUrl,
      LatLng location) async {
    return await _festivalsHttpServices.addFestival(
        name, addedDate, addedTime, description, imageUrl, location);
  }

  // Future<List<FestivalModel>> getPersonalFestivals() async {
  //   return await _festivalsHttpServices.getPersonalFestivals();
  // }
}
