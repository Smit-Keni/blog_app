import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

abstract interface class useCase<SuccessType,Params>{
  Future<Either<Failure,SuccessType>> call(Params params);


}