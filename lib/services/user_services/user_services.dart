import 'dart:convert';

import 'package:festivals_exam_4/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserHttpServices{
  Future<UserModel?> getUser() async {
    final userId=await _getUserId();
    Uri url = Uri.parse(
        'https://tadbirlar-4-default-rtdb.firebaseio.com/users.json?orderBy="localId"&equalTo="$userId"');
    try {
      final response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);

      if (data != null) {
        return UserModel.fromJson(data);
      }
      // print("festivals all: $loadedFestivals");

    } catch (e) {

    }
  }


   Future<String> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString("userData");

    if (userData == null) {
      // redirect to login
    }

    Map<String, dynamic> user = jsonDecode(userData!);

    return user['localId'];
  }
}