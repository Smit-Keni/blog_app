import 'package:fpdart/fpdart.dart';

import '../../../../core/common/entities/user.dart';
import '../../../../core/error/failures.dart';


abstract interface class authRepository{
  Future<Either<Failure,User>> signUpWithEmailPass({
    required String email,
    required String name,
    required String pass


});

  Future<Either<Failure,User>> loginWithEmailPass({
    required String email,
    required String pass


  });

  Future<Either<Failure,User>>currentUser();

  Future<Either<Failure,String?>>logout();
}