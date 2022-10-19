import 'package:dartz/dartz.dart';
import 'package:maleapp/data/networks/failure.dart';
import 'package:maleapp/data/resposes/store_details_response.dart';
import 'package:maleapp/domain/models/forgot_password_model.dart';
import 'package:maleapp/domain/models/home_model.dart';
import 'package:maleapp/domain/models/login_model.dart';

import '../../data/networks/requests.dart';
import '../models/store_details_model.dart';

abstract class Repository
{
  Future<Either<Failure,AuthenticationModel>>login(LoginRequest loginRequest);

  Future<Either<Failure,ForgotPasswordModel>>forgotPassword(ForgotPasswordRequest forgotPasswordRequest);

  Future<Either<Failure,AuthenticationModel>>register(RegisterRequest registerRequest);

  Future<Either<Failure,HomeModel>>getHome();

  Future<Either<Failure,StoreDetailsModel>>getStoreDetails();
}

