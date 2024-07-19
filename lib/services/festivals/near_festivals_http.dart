import 'dart:convert';
import 'package:festivals_exam_4/utils/datetime_extension.dart';
import 'package:http/http.dart' as http;
import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NearFestivalsHttpServices{
    Future<List<FestivalModel>> getNearFestivals() async {
     List<FestivalModel> loadedFestivals = [];
    List<FestivalModel> nearFestivals = [];

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
          // print(value);p
          loadedFestivals.add(FestivalModel.fromJson(value));
        });
        for (FestivalModel festival in loadedFestivals) {
          festival.addedDate.addAll(festival.addedTime);
          DateTime data = festival.addedDate.toDateTime();
          if (data.isAfter(DateTime.now())) {
            nearFestivals.add(festival);
          }
        }
      }
      print("nearFestivals:$nearFestivals");
      return nearFestivals;
    } catch (e) {
      print(e);
      return [];
    }
  }


}