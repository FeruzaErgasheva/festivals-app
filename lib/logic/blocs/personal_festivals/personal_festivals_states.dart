import 'package:festivals_exam_4/data/models/festival_model.dart';

sealed class PersonalFestivalsStates {}

final class InitialPersonalFestivalsState extends PersonalFestivalsStates {}

final class LoadingPersonalFestivalsState extends PersonalFestivalsStates {}

final class LoadedPersonalFestivalsState extends PersonalFestivalsStates {
  final List<FestivalModel> festivals;

  LoadedPersonalFestivalsState(this.festivals);
}

final class ErrorPersonalFestivalState extends PersonalFestivalsStates {
  final String message;

  ErrorPersonalFestivalState(this.message);
}
