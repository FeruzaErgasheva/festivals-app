import 'package:festivals_exam_4/data/models/user_model.dart';
import 'package:festivals_exam_4/services/auth_service.dart';
import 'package:festivals_exam_4/services/user_services/user_services.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserRepository {
  final UserHttpServices _userHttpServices;

  UserRepository({
    required UserHttpServices userHttpServices,
  }) : _userHttpServices = userHttpServices;

  

 

  Future<void>  addUser(String userName,String email) async {
    return await _userHttpServices.addUser(email, userName);
  }

  Future<UserModel?> getUser() async{
    return await  _userHttpServices.getUser();
  }
}