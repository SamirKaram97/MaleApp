import 'package:json_annotation/json_annotation.dart';
import 'package:maleapp/data/resposes/base_response.dart';
part 'store_details_response.g.dart';

@JsonSerializable()
class StoreDetailsResponse extends BaseResponse
{
  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "details")
  String? details;

  @JsonKey(name: "services")
  String? services;

  @JsonKey(name: "about")
  String? about;

  StoreDetailsResponse({required this.services,required this.about,required this.image,required this.title,required this.id,required this.details});

  factory StoreDetailsResponse.fromJson(Map<String,dynamic> json)=>_$StoreDetailsResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$StoreDetailsResponseToJson(this);
}