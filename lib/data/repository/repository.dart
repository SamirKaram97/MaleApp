import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:maleapp/app/extensions.dart';
import 'package:maleapp/data/data_source/local_data_source/local_data_source.dart';
import 'package:maleapp/data/data_source/remote_data_source/remote_data_source.dart';
import 'package:maleapp/data/mappers/mappers.dart';
import 'package:maleapp/data/networks/failure.dart';
import 'package:maleapp/data/networks/requests.dart';
import 'package:maleapp/data/resposes/forgot_password_response.dart';
import 'package:maleapp/data/resposes/store_details_response.dart';
import 'package:maleapp/domain/models/forgot_password_model.dart';
import 'package:maleapp/domain/models/home_model.dart';
import 'package:maleapp/domain/models/login_model.dart';
import 'package:maleapp/domain/models/store_details_model.dart';
import 'package:maleapp/domain/repository/repository.dart';
import '../networks/error_handler.dart';
import '../networks/network_info.dart';
import '../resposes/Authentication_respose.dart';
import '../resposes/home_response.dart';

class RepositoryImpl implements Repository {
  final RemoteDatasource remoteDatasource;
  final LocalDataSource localDatasource;
  final NetworkInfo networkInfo;

  RepositoryImpl(
      {required this.localDatasource,
      required this.networkInfo,
      required this.remoteDatasource});

  @override
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequest loginRequest) async {
    bool isConnected = await networkInfo.isNetworkConnectionWork();
    if (isConnected) {
      try {
        AuthenticationResponse authenticationResponse =
            await remoteDatasource.login(loginRequest);
        print(
            'authenticationResponse.status is ${authenticationResponse.status}');
        if (authenticationResponse.status == ApiInternalState.success) {
          return right(authenticationResponse.toDomain());
        } else {
          print(authenticationResponse.status);
          return left(Failure(
              message:
                  authenticationResponse.message ?? ResponseMessage.DEFAULT,
              code: 50));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    }
    return left(DataSource.NO_INTERNET.getFailure());
  }

  @override
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword(
      ForgotPasswordRequest forgotPasswordRequest) async {
    bool isConnected = await networkInfo.isNetworkConnectionWork();
    if (isConnected) {
      try {
        ForgotPasswordResponse response =
            await remoteDatasource.forgotPassword(forgotPasswordRequest);
        if (response.status == 1) {
          return right(response.toDomain());
        } else {
          return left(Failure(
              message: response.message ?? ResponseMessage.DEFAULT, code: 50));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    }
    return left(DataSource.NO_INTERNET.getFailure());
    ;
  }

  @override
  Future<Either<Failure, AuthenticationModel>> register(
      RegisterRequest registerRequest) async {
    bool isConnected = await networkInfo.isNetworkConnectionWork();
    if (isConnected) {
      try {
        AuthenticationResponse response =
            await remoteDatasource.register(registerRequest);
        if (response.status == ApiInternalState.success) {
          return right(response.toDomain());
        } else {
          return left(Failure(
              message: response.message ?? ResponseMessage.DEFAULT,
              code: response.status ?? ResponseCode.DEFAULT));
        }
      } catch (error) {
        return left(ErrorHandler.handle(error).failure);
      }
    } else {
      return left(DataSource.NO_INTERNET.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeModel>> getHome() async {
    try {
      // HomeResponse localResponse = await localDatasource.getHome();
      HomeResponse localResponse=await localDatasource.getHomeShared();
      return right(localResponse.toDomain());
    } catch (cacheError) {
      bool isConnected = await networkInfo.isNetworkConnectionWork();
      if (isConnected) {
        try {
          HomeResponse response = await remoteDatasource.getHome();
          if (response.status == ApiInternalState.success) {
            if (response.homeDataResponse != null) {
              // localDatasource.saveHomeData(response.homeDataResponse!);
              localDatasource.saveHomeDataToShared(json.encode(response.toJson()));
            }

            return right(response.toDomain());
          } else {
            return left(Failure(
                message: response.message ?? ResponseMessage.DEFAULT,
                code: response.status ?? ResponseCode.DEFAULT));
          }
        } catch (error) {
          return left(ErrorHandler.handle(error).failure);
        }
      } else {
        return left(DataSource.NO_INTERNET.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetailsModel>> getStoreDetails() async {
    try {
      StoreDetailsResponse? localResponse = await localDatasource.getStoreDetails();// not important to make it future function
      print(" about is ${localResponse.about}");
      return right(localResponse.toDomain());
    } catch (cacheError) {
      bool isConnected = await networkInfo.isNetworkConnectionWork();
      if (isConnected) {
        try {
          StoreDetailsResponse response =
              await remoteDatasource.getStoreDetailsResponse();
          if (response.status == ApiInternalState.success) {
            localDatasource.saveStoreDetailsData(response);
            return right(response.toDomain());
          } else {
            return left(Failure(
                message: response.message ?? ResponseMessage.DEFAULT,
                code: response.status ?? ResponseCode.DEFAULT));
          }
        } catch (error) {
          return left(ErrorHandler.handle(error).failure);
        }
      } else {
        return left(DataSource.NO_INTERNET.getFailure());
      }
    }
  }
}
