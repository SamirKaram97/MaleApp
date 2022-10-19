// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDetailsResponse _$StoreDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    StoreDetailsResponse(
      services: json['services'] as String?,
      about: json['about'] as String?,
      image: json['image'] as String?,
      title: json['title'] as String?,
      id: json['id'] as int?,
      details: json['details'] as String?,
    )
      ..message = json['message'] as String?
      ..status = json['status'] as int?;

Map<String, dynamic> _$StoreDetailsResponseToJson(
        StoreDetailsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
      'image': instance.image,
      'id': instance.id,
      'title': instance.title,
      'details': instance.details,
      'services': instance.services,
      'about': instance.about,
    };
