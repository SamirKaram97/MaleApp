import 'package:dartz/dartz.dart';
import 'package:maleapp/data/networks/failure.dart';
import 'package:maleapp/domain/models/login_model.dart';
import 'package:maleapp/domain/repository/repository.dart';
import 'package:maleapp/domain/usecase/base_usecase.dart';

import '../../data/networks/requests.dart';

class LoginUseCase implements BaseUseCase<LoginInputModel,AuthenticationModel>
{
  final Repository repository;

  LoginUseCase({required this.repository});
  @override
  Future<Either<Failure, AuthenticationModel>> execute(LoginInputModel input) {
    return repository.login(LoginRequest(userName:input.userName,password:input.password));
  }


}

class LoginInputModel
{
  String userName;
  String password;
  LoginInputModel({required this.password,required this.userName});
}