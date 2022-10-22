import 'package:dartz/dartz.dart';
import 'package:maleapp/data/networks/failure.dart';
import 'package:maleapp/data/resposes/store_details_response.dart';
import '../models/store_details_model.dart';

import '../repository/repository.dart';
import 'base_usecase.dart';

class GetStoreDetailsUseCase extends BaseUseCase<void,StoreDetailsModel>
{
  final Repository repository;

  GetStoreDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, StoreDetailsModel>> execute(void input) async{
    return await repository.getStoreDetails();
  }



}