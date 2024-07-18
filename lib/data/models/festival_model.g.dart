// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FestivalModel _$FestivalModelFromJson(Map<String, dynamic> json) =>
    FestivalModel(
        location: json['location'] as List<dynamic>,
        id: json['id'] as String,
        addedDate: json['addedDate'] as List<dynamic>,
        addedTime: json['addedTime'] as List<dynamic>,
        description: json['description'] as String,
        imageUrl: json['imageUrl'] as String,
        name: json['name'] as String,
        userID: json['userId'] as String,
        attendants: json["attendants"]);

Map<String, dynamic> _$FestivalModelToJson(FestivalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'userID': instance.userID,
      'addedTime': instance.addedTime,
      'addedDate': instance.addedDate,
      'location': instance.location,
    };
