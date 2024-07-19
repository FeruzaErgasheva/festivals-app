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

     
        return UserModel.fromJson(data);
      
      // print("festivals all: $loadedFestivals");

    } catch (e) {

    }
  }

  Future<void> addUser(
    String email,
    String userName
  ) async {
    // final userToken = await _getUserToken();
    final userId = await _getUserId();
    Uri url = Uri.parse(
        "https://tadbirlar-4-default-rtdb.firebaseio.com/users.json");

    try {
     
      Map<String, dynamic> userData = {
        "userId": userId,
        "email":email,
        "userName":userName
      };
      final response = await http.post(
        url,
        body: jsonEncode(userData),
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw (errorData['error']);
      }

    } catch (e) {
      rethrow;
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