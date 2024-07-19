import 'package:bloc/bloc.dart';
import 'package:festivals_exam_4/data/repositories/festivals/near_festivals_repository.dart';
import 'package:festivals_exam_4/logic/blocs/near_fetsivals/near_festivals_events.dart';
import 'package:festivals_exam_4/logic/blocs/near_fetsivals/near_festivals_states.dart';
class NearFestivalsBloc extends Bloc<NearFestivalsEvents, NearFestivalsStates> {
  final NearFestivalsRepository _nearFestivalsRepositories;

  NearFestivalsBloc({required NearFestivalsRepository nearFestivalsRepositories})
      : _nearFestivalsRepositories = nearFestivalsRepositories,
        super(InitialNearFestivalsState()) {
    on<GetNearFestivalsEvent>(_getNearFestivals);
  }

  void _getNearFestivals(
    GetNearFestivalsEvent event,
    Emitter<NearFestivalsStates> emit,
  ) async {
    emit(LoadingNearFestivalsState());

    try {
      final nearFestivals = await _nearFestivalsRepositories.getNearFestivals();
      emit(LoadedNearFestivalsState(nearFestivals));
    } catch (e) {
      emit(ErrorNearFestivalState(e.toString()));
    }
  }
}
