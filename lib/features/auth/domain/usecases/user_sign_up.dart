

import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/entities/user.dart';

class userSignUp implements useCase<User,userSignUpParams>{
  final authRepository AuthRepository;
  const userSignUp(this.AuthRepository);

  @override
  Future<Either<Failure, User>> call(userSignUpParams params) async{
    return await AuthRepository.signUpWithEmailPass(
        email: params.email,
        name: params.name,
        pass: params.pass);

  }

}

class userSignUpParams{
  final String email;
  final String name;
  final String pass;

  userSignUpParams({
    required this.email,
    required this.name,
    required this.pass
});
}