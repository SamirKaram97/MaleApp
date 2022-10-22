import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse
{
  @JsonValue('message')
  String? message;

  @JsonValue('status')
  int? status;

}
