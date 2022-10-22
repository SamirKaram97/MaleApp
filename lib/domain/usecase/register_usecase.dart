import 'package:dartz/dartz.dart';
import 'package:maleapp/app/di.dart';
import 'package:maleapp/data/networks/failure.dart';
import 'package:maleapp/domain/repository/repository.dart';
import 'package:maleapp/domain/usecase/base_usecase.dart';

import '../../data/networks/requests.dart';
import '../models/login_model.dart';

class RegisterUseCase extends BaseUseCase<RegisterInputModel,AuthenticationModel>
{
  final Repository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, AuthenticationModel>> execute(RegisterInputModel input) {
    return repository.register(RegisterRequest(email: input.email,password: input.password,userName: input.userName,mobileNumber: input.mobileNumber));
  }

}

class RegisterInputModel
{
  String userName;
  String password;
  String mobileNumber;
  String email;

  RegisterInputModel({required this.password,required this.userName,required this.mobileNumber,required this.email});
}
