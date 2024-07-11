import 'package:blogapp/core/common/entities/user.dart';
import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class CurrentUser implements useCase<User,noParams>{
  final authRepository AuthRepository;
  CurrentUser(this.AuthRepository);


  @override
  Future<Either<Failure, User>> call(noParams params)async{
    return await AuthRepository.currentUser();
  }

}

class noParams{

}