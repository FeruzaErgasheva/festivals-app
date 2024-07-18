import 'package:festivals_exam_4/data/models/festival_model.dart';
import 'package:festivals_exam_4/services/festivals_http_services.dart';

class FestivalsRepositories{
  final FestivalsHttpServices _festivalsHttpServices;

  FestivalsRepositories({
    required FestivalsHttpServices festivalsHttpServices,
  }) : _festivalsHttpServices = festivalsHttpServices;


    Future<List<FestivalModel>> getFestivals() async {
    return await _festivalsHttpServices.getFestivals();
  }

   Future<List<FestivalModel>> getFestivalsWithinWeek() async {
    return await _festivalsHttpServices.getFestivalsWithinWeek();
  }


  Future<void> incrementAttendants(String id, int attendants, int orders) async{
    await _festivalsHttpServices.incrementAttendants(id, attendants, orders);
  }
}