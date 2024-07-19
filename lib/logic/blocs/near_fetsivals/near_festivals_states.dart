import 'package:festivals_exam_4/data/models/festival_model.dart';

sealed class NearFestivalsStates {}

final class InitialNearFestivalsState extends NearFestivalsStates {}

final class LoadingNearFestivalsState extends NearFestivalsStates {}

final class LoadedNearFestivalsState extends NearFestivalsStates {
  final List<FestivalModel> festivals;

  LoadedNearFestivalsState(this.festivals);
}

final class ErrorNearFestivalState extends NearFestivalsStates {
  final String message;

  ErrorNearFestivalState(this.message);
}
