import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/services/festivals/personal_festivals_http_services.dart';

class PersonalFestivalsRepositories {
  final PersonalFestivalsHttpServices _personalFestivalsHttpServices;

  PersonalFestivalsRepositories({
    required PersonalFestivalsHttpServices personalFestivalsHttpServices,
  }) : _personalFestivalsHttpServices = personalFestivalsHttpServices;



  Future<List<FestivalModel>> getPersonalFestivals() async {
    return await _personalFestivalsHttpServices.getPersonalFestivals();
  }
}
