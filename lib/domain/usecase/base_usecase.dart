import 'package:dartz/dartz.dart';
import 'package:maleapp/data/networks/failure.dart';
import 'package:maleapp/presentation/common/freezed_data_classes.dart';

abstract class BaseUseCase<In,Out>
{
  Future<Either<Failure,Out>> execute(In input);
}


