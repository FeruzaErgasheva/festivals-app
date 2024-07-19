import 'package:bloc/bloc.dart';
import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/data/repositories/festivals/festivals_repositories.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_events.dart';
import 'package:festivals_exam_4/logic/blocs/festivals/festivals_states.dart';

class FestivalsBloc extends Bloc<FestivalsEvents, FestivalsState> {
  final FestivalsRepositories _festivalsRepositories;

  FestivalsBloc({required FestivalsRepositories festivalsRepositories})
      : _festivalsRepositories = festivalsRepositories,
        super(InitialFestivalsState()) {
    on<GetFestivalsEvent>(_getFestivals);
    on<GetFestivalWithinWeek>(_getFestivalsWithinWeek);
    on<IncrementFestivalAttendantsEvent>(_incrementFestivalAttendants);
    on<AddFestivalEvent>(_addFestival);
    // on<GetPersonalFestivals>(_getPersonalFestivals);
  }

  void _incrementFestivalAttendants(IncrementFestivalAttendantsEvent event,
      Emitter<FestivalsState> emit) async {
    if (state is LoadedFestivalsState) {
      List<FestivalModel> existingFestivals =
          (state as LoadedFestivalsState).festivals;
      emit(LoadingFestivalsState());

      try {
        emit(LoadedFestivalsState(existingFestivals));

        await _festivalsRepositories.incrementAttendants(
          event.id,
          event.attendants,
        );
        // Update the festival list with the incremented attendants
        for (var festival in existingFestivals) {
          if (festival.id == event.id) {
            festival.attendants = event.attendants;
          }
        }
        // emit(LoadedFestivalsState(existingFestivals));
      } catch (e) {
        emit(ErrorProductsState(e.toString()));
      }
    } else {
      // Handle the case where the state is not LoadedFestivalsState
      emit(ErrorProductsState(
          "Cannot increment attendants. Festivals are not loaded."));
    }
  }

  void _getFestivals(
    GetFestivalsEvent event,
    Emitter<FestivalsState> emit,
  ) async {
    emit(LoadingFestivalsState());

    try {
      final festivals = await _festivalsRepositories.getFestivals();
      emit(LoadedFestivalsState(festivals));
    } catch (e) {
      emit(ErrorProductsState(e.toString()));
    }
  }

  void _getFestivalsWithinWeek(
    GetFestivalWithinWeek event,
    Emitter<FestivalsState> emit,
  ) async {
    emit(LoadingFestivalsState());

    try {
      final comingFestivals =
          await _festivalsRepositories.getFestivalsWithinWeek();
      emit(LoadedFestivalsState(comingFestivals));
    } catch (e) {
      emit(ErrorProductsState(e.toString()));
    }
  }

  // void _getPersonalFestivals(
  //   GetPersonalFestivals event,
  //   Emitter<FestivalsState> emit,
  // ) async {
  //   emit(LoadingFestivalsState());

  //   try {
  //     final personalFestivals =
  //         await _festivalsRepositories.getPersonalFestivals();
  //     emit(LoadedFestivalsState(personalFestivals));
  //   } catch (e) {
  //     emit(ErrorProductsState(e.toString()));
  //   }
  // }

  void _addFestival(
    AddFestivalEvent event,
    Emitter<FestivalsState> emit,
  ) async {
    List<FestivalModel> existingFestivals = [];
    if (state is LoadedFestivalsState) {
      existingFestivals = (state as LoadedFestivalsState).festivals;
    }
    emit(LoadingFestivalsState());

    try {
      final festival = await _festivalsRepositories.addFestival(
          event.name,
          event.addedDate,
          event.addedTime,
          event.description,
          event.imageUrl,
          event.location);
      existingFestivals.add(festival);
      emit(LoadedFestivalsState(existingFestivals));
    } catch (e) {
      emit(ErrorProductsState(e.toString()));
    }
  }

 
}
