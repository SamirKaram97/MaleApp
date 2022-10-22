import 'package:maleapp/data/resposes/base_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Authentication_respose.g.dart';

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {

  @JsonKey(name: "customer")
  CustomerResponse? customerResponse;

  @JsonKey(name: "contacts")
  ContactsResponse? contactsResponse;

  AuthenticationResponse({this.contactsResponse, this.customerResponse});

  //fromJson
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class CustomerResponse {

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;

  CustomerResponse({this.name, this.id, this.numOfNotifications});

  //fromJson
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "link")
  String? link;

  ContactsResponse({this.phone, this.email, this.link});

  //fromJson
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}
