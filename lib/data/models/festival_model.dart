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

  FestivalModel({
    required this.location,
    required this.id,
    required this.addedDate,
    required this.addedTime,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.userID,
    required this.attendants
  });

  DateTime get time {
    List<dynamic> combinedDateTime = [...addedDate, ...addedTime];
    DateTime? combined = DateTime.tryParse(combinedDateTime.toString());

    return combined ?? DateTime.now(); // Return combined DateTime or current time if parsing fails
  }
  LatLng get loc {
    if (location.length >= 2 &&
        location[0] is double &&
        location[1] is double) {
      double latitude = location[0];
      double longitude = location[1];
      return LatLng(latitude, longitude);
    } else {
      throw Exception('Invalid location format');
    }
  }

  factory FestivalModel.fromJson(Map<String, dynamic> json) =>
      _$FestivalModelFromJson(json);
}
