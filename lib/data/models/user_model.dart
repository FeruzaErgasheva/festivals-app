class UserModel {
  String userId;
  String email;
  String imageUrl;
  String userName;

  UserModel(
      {required this.email,
      required this.userId,
      required this.userName,
      this.imageUrl =
          "https://t3.ftcdn.net/jpg/06/17/13/26/360_F_617132669_YptvM7fIuczaUbYYpMe3VTLimwZwzlWf.jpg"});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        userName: json['userName'],
        userId: json['userId'],
        imageUrl: json['imageUrl']);
  }
}
