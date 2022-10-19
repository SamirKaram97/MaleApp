import 'package:maleapp/data/networks/app_api.dart';
import 'package:maleapp/data/networks/error_handler.dart';
import 'package:maleapp/data/networks/requests.dart';
import 'package:maleapp/data/resposes/Authentication_respose.dart';
import 'package:maleapp/data/resposes/home_response.dart';
import 'package:maleapp/data/resposes/store_details_response.dart';
import 'package:maleapp/domain/models/forgot_password_model.dart';

import '../../resposes/forgot_password_response.dart';

abstract class RemoteDatasource
{
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest forgotPasswordRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<HomeResponse> getHome();
  Future<StoreDetailsResponse> getStoreDetailsResponse();
}

class RemoteDatasourceImpl implements RemoteDatasource
{
  final AppServiceClient appServiceClient;

  RemoteDatasourceImpl({required this.appServiceClient});

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest)async {
   return  await appServiceClient.login(loginRequest.userName, loginRequest.password);


  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(ForgotPasswordRequest forgotPasswordRequest)async {
    return await appServiceClient.forgotPassword(forgotPasswordRequest.email);
  }

  @override
  Future<AuthenticationResponse> register(RegisterRequest registerRequest)async {
    return await appServiceClient.register(registerRequest.email, registerRequest.password, registerRequest.userName, registerRequest.mobileNumber);
  }

  @override
  Future<HomeResponse> getHome()async {
    return await appServiceClient.getHome();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetailsResponse()async {
    return await appServiceClient.getStoreDetails();
  }
}