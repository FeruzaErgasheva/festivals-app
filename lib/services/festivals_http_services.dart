import 'dart:convert';

import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/utils/datetime_extension.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FestivalsHttpServices {
  Future<List<FestivalModel>> getFestivals() async {
    List<FestivalModel> loadedFestivals = [];
    Uri url = Uri.parse(
        "https://tadbirlar-4-default-rtdb.firebaseio.com/festivals.json");
    try {
      final response = await http.get(url);
      Map data = jsonDecode(response.body);
      // print(data);

      if (data != null) {
        data.forEach((key, value) {
          value['id'] = key;
          // print(key);
          // print(value);
          loadedFestivals.add(FestivalModel.fromJson(value));
        });
      }
      print("festivals all: $loadedFestivals");

      return loadedFestivals;
    } catch (e) {
      return [];
    }
  }

  Future<List<FestivalModel>> getFestivalsWithinWeek() async {
    List<FestivalModel> loadedFestivals = [];
    List<FestivalModel> comingFestivals = [];

    Uri url = Uri.parse(
        "https://tadbirlar-4-default-rtdb.firebaseio.com/festivals.json");
    try {
      final response = await http.get(url);
      Map data = jsonDecode(response.body);
      // print(data);

      if (data != null) {
        data.forEach((key, value) {
          value['id'] = key;
          // print(key);
          // print(value);
          loadedFestivals.add(FestivalModel.fromJson(value));
        });
        for (FestivalModel festival in loadedFestivals) {
          festival.addedDate.addAll(festival.addedTime);
          DateTime data = festival.addedDate.toDateTime();
          if (data.isWithinNext7Days()) {
            comingFestivals.add(festival);
          }
        }
      }

      print("comingFestivals:$comingFestivals");
      return comingFestivals;
    } catch (e) {
      print(e);
      return [];
    }
  }

 Future<void> incrementAttendants(String id,  int attendants, int orders) async {
    final userToken = await _getUserToken();
    Uri url = Uri.parse("https://tadbirlar-4-default-rtdb.firebaseio.com/festivals/$id.json");
    final updatedAttendants=attendants+orders;
    try {
      final response = await http.patch(url,
          body: jsonEncode({
            "attendants": updatedAttendants,
          }));

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw (errorData['error']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<FestivalModel> addFestival(
    String name,
    List<int> addedDate,
    List<int> addedTime,
    String description,
    String imageUrl,
    List<int> location,
  ) async {
    final userToken = await _getUserToken();
    final userId = await _getUserId();
    Uri url = Uri.parse(
        "https://tadbirlar-4-default-rtdb.firebaseio.com/festivals.json?auth=$userToken");

    try {
      Map<String, dynamic> festivalData = {
        "name": name,
        "addedDate": addedDate,
        "addedTime": addedTime,
        "description": description,
        "imageUrl": imageUrl,
        "location": location,
        "userId": userId
      };
      final response = await http.post(
        url,
        body: jsonEncode(festivalData),
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw (errorData['error']);
      }

      final data = jsonDecode(response.body); //her
      festivalData['id'] = data['name'];
      print(festivalData);

      FestivalModel newFestival = FestivalModel.fromJson(festivalData);

      return newFestival;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> _getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString("userData");

    if (userData == null) {
      // redirect to login
    }

    Map<String, dynamic> user = jsonDecode(userData!);
    bool isTokenExpired = DateTime.now().isAfter(
      DateTime.parse(
        user['expiresIn'],
      ),
    );

    if (!isTokenExpired) {
      // refresh token
      user = await _refreshToken(user);
      prefs.setString("userData", jsonEncode(user));
    }

    return user['idToken'];
  }

  Future<Map<String, dynamic>> _refreshToken(Map<String, dynamic> user) async {
    Uri url = Uri.parse(
        "https://securetoken.googleapis.com/v1/token?key=AIzaSyAc5BvJzSKz9XpJXl1I-8YCpzg0p9VGcYA");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            "grant_type": "refresh_token",
            "refresh_token": user['refreshToken'],
          },
        ),
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.body);
        throw (errorData['error']);
      }

      final data = jsonDecode(response.body);

      user['refreshToken'] = data['refresh_token'];
      user['idToken'] = data['id_token'];
      user['expiresIn'] = DateTime.now()
          .add(
            Duration(
              seconds: int.parse(
                data['expires_in'],
              ),
            ),
          )
          .toString();
      return user;
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

void main(List<String> args) {
  FestivalsHttpServices festivalsHttpServices = FestivalsHttpServices();
  // festivalsHttpServices.addFestival(
  //   "something",
  //   [2024, 10, 16],
  //   [20, 45],
  //   'THis is description',
  //   "https://ideafoster.com/wp-content/uploads/2023/03/hackaton-concepto-funciona-922.jpeg",
  //   [24, 35],
  // );
  festivalsHttpServices.getFestivalsWithinWeek();
}
