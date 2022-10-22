import 'package:dartz/dartz.dart';
import 'package:maleapp/data/networks/failure.dart';
import 'package:maleapp/data/resposes/forgot_password_response.dart';
import 'package:maleapp/domain/usecase/base_usecase.dart';

import '../../data/networks/requests.dart';
import '../models/forgot_password_model.dart';
import '../repository/repository.dart';

class ForgotPasswordUseCase extends BaseUseCase<ForgotPasswordInputModel,ForgotPasswordModel>
{
  final Repository repository;

  ForgotPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, ForgotPasswordModel>> execute(ForgotPasswordInputModel input) {
    return repository.forgotPassword(ForgotPasswordRequest(email: input.email));
  }


}


class ForgotPasswordInputModel
{
  String email;
  ForgotPasswordInputModel({required this.email});
}