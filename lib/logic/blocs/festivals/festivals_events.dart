import 'package:google_maps_flutter/google_maps_flutter.dart';

sealed class FestivalsEvents {}


final class IncrementFestivalAttendantsEvent extends FestivalsEvents {
  final String id;
  final int attendants;

  IncrementFestivalAttendantsEvent({
    required this.id,
    required this.attendants,
  });
}

final class DeleteFestivalEvent extends FestivalsEvents {
  final String id;

  DeleteFestivalEvent({required this.id});
}


final class AddFestivalEvent extends FestivalsEvents {
  final String name;
  final String imageUrl;
  final String addedDate;
  final String addedTime;
  final String description;
  final LatLng location;

  AddFestivalEvent({
    required this.name,
    required this.imageUrl,
    required this.addedDate,
    required this.addedTime,
    required this.description,
    required this.location
  });
}
final class GetFestivalWithinWeek extends FestivalsEvents {}

final class GetFestivalsEvent extends FestivalsEvents {}


