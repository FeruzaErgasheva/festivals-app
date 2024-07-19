class UserModel {
  String userId;
  String email;
  String imageUrl;

  UserModel(
      {required this.email,
      required this.userId,
      this.imageUrl =
          "https://t3.ftcdn.net/jpg/06/17/13/26/360_F_617132669_YptvM7fIuczaUbYYpMe3VTLimwZwzlWf.jpg"});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        userId: json['userId'],
        imageUrl: json['imageUrl']);
  }
}
