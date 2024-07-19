import 'package:festivals_exam_4/data/models/user_model.dart';

sealed class UserStates{

}


final class InitialUserState extends UserStates{}
final class LoadingUserState extends UserStates{}

final class LoadedUserState extends UserStates{
  final UserModel user;
  LoadedUserState({required this.user});
}

final class ErrorUserState extends UserStates{
  String message;
  ErrorUserState(this.message);

}
