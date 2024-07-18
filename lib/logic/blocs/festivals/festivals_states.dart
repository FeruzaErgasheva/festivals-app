


import 'package:festivals_exam_4/data/models/festival_model.dart';

sealed class FestivalsState {}

final class InitialFestivalsState extends FestivalsState {}

final class LoadingFestivalsState extends FestivalsState {}

final class LoadedFestivalsState extends FestivalsState {
  final List<FestivalModel> festivals;

  LoadedFestivalsState(this.festivals);
}

final class ErrorProductsState extends FestivalsState {
  final String message;

  ErrorProductsState(this.message);
}