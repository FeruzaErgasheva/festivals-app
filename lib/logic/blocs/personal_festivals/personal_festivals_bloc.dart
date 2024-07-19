import 'package:bloc/bloc.dart';
import 'package:festivals_exam_4/data/repositories/festivals/personal_festivals_repositories.dart';
import 'package:festivals_exam_4/logic/blocs/personal_festivals/person_festivals_events.dart';
import 'package:festivals_exam_4/logic/blocs/personal_festivals/personal_festivals_states.dart';

class PersonalFestivalsBloc extends Bloc<PersonFestivalsEvents, PersonalFestivalsStates> {
  final PersonalFestivalsRepositories _personalFestivalsRepositories;

  PersonalFestivalsBloc({required PersonalFestivalsRepositories personalFestivalsRepositories})
      : _personalFestivalsRepositories = personalFestivalsRepositories,
        super(InitialPersonalFestivalsState()) {
    on<GetPersonalFestivalsEvent>(_getPersonalFestivals);
  }
 void _getPersonalFestivals(
    GetPersonalFestivalsEvent event,
    Emitter<PersonalFestivalsStates> emit,
  ) async {
    emit(LoadingPersonalFestivalsState());

    try {
      final personalFestivals = await _personalFestivalsRepositories.getPersonalFestivals();
      emit(LoadedPersonalFestivalsState(personalFestivals));
    } catch (e) {
      emit(ErrorPersonalFestivalState(e.toString()));
    }
  }
}




