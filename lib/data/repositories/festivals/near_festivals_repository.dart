import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/services/festivals/near_festivals_http.dart';

class NearFestivalsRepository{
    final NearFestivalsHttpServices _nearFestivalsHttpServices;

  NearFestivalsRepository({
    required NearFestivalsHttpServices nearFestivalsHttpServices,
  }) : _nearFestivalsHttpServices = nearFestivalsHttpServices;



  Future<List<FestivalModel>> getNearFestivals() async {
    return await _nearFestivalsHttpServices.getNearFestivals();
  }
}