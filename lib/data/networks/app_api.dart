
import 'package:dio/dio.dart';
import 'package:maleapp/app/constants.dart';
import 'package:maleapp/data/resposes/Authentication_respose.dart';
import 'package:maleapp/data/resposes/forgot_password_response.dart';
import 'package:maleapp/data/resposes/home_response.dart';
import 'package:retrofit/http.dart';

import '../resposes/store_details_response.dart';
part 'app_api.g.dart';


@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient
{
  factory AppServiceClient(Dio dio,{String baseUrl})=_AppServiceClient;

  @POST(Constants.login)
  Future<AuthenticationResponse> login(
      @Field("email") String email,
      @Field("password") String password
      );


  @POST(Constants.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword(
      @Field("email") String email,
      );


  @POST(Constants.register)
  Future<AuthenticationResponse> register(
      @Field("email") String email,
      @Field("password") String password,
      @Field("user_name") String userName,
      @Field("mobile_number") String mobileNumber,
      );

  @GET(Constants.home)
  Future<HomeResponse> getHome();


  @GET(Constants.storeDetails)
  Future<StoreDetailsResponse> getStoreDetails();

}



