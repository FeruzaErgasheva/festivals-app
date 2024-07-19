import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalFestivalsHttpServices{
    Future<List<FestivalModel>> getPersonalFestivals() async {
    List<FestivalModel> personalFestivals = [];
    final userId = await _getUserId();

    Uri url = Uri.parse(
        'https://tadbirlar-4-default-rtdb.firebaseio.com/festivals.json?orderBy="userId"&equalTo="$userId"');
    try {
      final response = await http.get(url);
      Map data = jsonDecode(response.body);
      // print(data);

      if (data != null) {
        data.forEach((key, value) {
          value['id'] = key;
          // print(key);
          // print(value);p
          personalFestivals.add(FestivalModel.fromJson(value));
        });
        
      }
      // print("comingFestivals:$comingFestivals");
      return personalFestivals;
    } catch (e) {
      print(e);
      return [];
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