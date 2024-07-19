import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'festival_model.g.dart';

@JsonSerializable()
class FestivalModel {
  String id;
  String name;
  String description;
  String imageUrl;
  String userID;
  List addedTime;
  List addedDate;
  List location;
  int attendants;

  FestivalModel(
      {required this.location,
      required this.id,
      required this.addedDate,
      required this.addedTime,
      required this.description,
      required this.imageUrl,
      required this.name,
      required this.userID,
      required this.attendants});

  // DateTime get time {
  //   // Combine addedDate and addedTime properly
  //   try {
  //     print(addedDate);
  //     DateTime combined = DateTime(
  //         addedDate[0],
  //         addedDate[1],
  //         addedDate[2], // Year, Month, Day
  //         addedTime[0],
  //         addedTime[1],
  //         0 // Hour, Minute, Second
  //         );
  //     return combined;
  //   } catch (e) {
  //     // Return current time if parsing fails
  //     return DateTime.now();
  //   }
  // }

  Future<List<String>> getPlaceMarkStrings() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          double.parse(location[0]), double.parse(location[1]));
      print(placemarks);
      List<String> placeMarkStrings = placemarks.map((placemark) {
        return "${placemark.name}, ${placemark.locality}, ${placemark.country}";
      }).toList();
      return placeMarkStrings;
    } catch (e) {
      print("Error: ${e.toString()}");
      return []; // Return an empty list or handle the error as needed
    }
  }

  factory FestivalModel.fromJson(Map<String, dynamic> json) =>
      _$FestivalModelFromJson(json);
}
