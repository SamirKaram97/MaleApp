import 'package:dartz/dartz.dart';
import 'package:maleapp/data/networks/failure.dart';
import 'package:maleapp/domain/models/home_model.dart';
import 'package:maleapp/domain/repository/repository.dart';

import 'base_usecase.dart';

class GetHomeUseCase extends BaseUseCase<void,HomeModel>
{
  final Repository repository;

  GetHomeUseCase({required this.repository});

  @override
  Future<Either<Failure, HomeModel>> execute(void input)async {
   return await repository.getHome();
  }

}