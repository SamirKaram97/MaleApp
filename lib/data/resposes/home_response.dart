
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:maleapp/data/resposes/base_response.dart';
part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse extends BaseResponse
{
  @JsonKey(name: 'data')
  HomeDataResponse? homeDataResponse;

  HomeResponse({this.homeDataResponse});

  factory HomeResponse.fromJson(Map<String,dynamic> json)=>_$HomeResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$HomeResponseToJson(this);
}


@JsonSerializable()
class HomeDataResponse
{
  @JsonKey(name: 'services')
  List<ServiceResponse> servicesResponse;

  @JsonKey(name: 'banners')
  List<BannerResponse> bannersResponses;

  @JsonKey(name: 'stores')
  List<StoreResponse> storesResponses;

  HomeDataResponse({required this.servicesResponse,required this.bannersResponses,required this.storesResponses});

  factory HomeDataResponse.fromJson(Map<String,dynamic> json)=>_$HomeDataResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$HomeDataResponseToJson(this);
}

@JsonSerializable()
class ServiceResponse
{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'image')
  String? image;

  ServiceResponse({this.id,this.title,this.image});

  factory ServiceResponse.fromJson(Map<String,dynamic> json)=>_$ServiceResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$ServiceResponseToJson(this);

}

@JsonSerializable()
class BannerResponse
{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'link')
  String? link;

  BannerResponse({this.id,this.title,this.image,this.link});

  factory BannerResponse.fromJson(Map<String,dynamic> json)=>_$BannerResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$BannerResponseToJson(this);
}

@JsonSerializable()
class StoreResponse
{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'image')
  String? image;

  StoreResponse({this.id,this.title,this.image});

  factory StoreResponse.fromJson(Map<String,dynamic> json)=>_$StoreResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$StoreResponseToJson(this);

}

