import 'package:bloc/bloc.dart';
import 'package:festivals_exam_4/data/repositories/user_repository.dart';
import 'package:festivals_exam_4/logic/blocs/user/user_events.dart';
import 'package:festivals_exam_4/logic/blocs/user/user_state.dart';
class UserBloc extends Bloc<UserEvents, UserStates> {
  final UserRepository _userRepository;

  UserBloc({required  UserRepository userRepository})
      : _userRepository = userRepository,
        super(InitialUserState()) {
    on<GetUserEvent>(_getUser);

    on<AddUserEvent>(_addUser);
  }

  void _getUser(
    GetUserEvent event,
    Emitter<UserStates> emit,
  ) async {
    emit(LoadingUserState());

    try {
      final user = await _userRepository.getUser();
      emit(LoadedUserState(user: user!));
    } catch (e) {
      emit(ErrorUserState(e.toString()));
    }
  }

  void _addUser(event, emit) async {
     emit(LoadingUserState());
     try {
       await _userRepository.addUser(event.user, event.email);
     } catch (e) {
       
     }
  }
  
}