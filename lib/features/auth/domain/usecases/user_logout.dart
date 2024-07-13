import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';
import 'package:blogapp/features/auth/domain/usecases/current_user.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/entities/user.dart';

class UserLogout implements useCase<String?,noParams>{
  final authRepository AuthRepository;
  UserLogout(this.AuthRepository);



  @override
  Future<Either<Failure, String?>> call(noParams params) async{
    return await AuthRepository.logout();
  }


}