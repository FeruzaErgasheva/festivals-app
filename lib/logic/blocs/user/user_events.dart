sealed class UserEvents{}


final class AddUserEvent extends UserEvents {
  final String email;
  final String userName;

  AddUserEvent({
    required this.email,
    required this.userName
  });
}

final class GetUserEvent extends UserEvents {

}