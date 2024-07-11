import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../../core/common/entities/user.dart';

class UserLogin implements useCase<User,UserLoginParams> {
  final authRepository AuthRepository;
  const UserLogin(this.AuthRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async{
    return await AuthRepository.loginWithEmailPass(
        email: params.email,
        pass: params.password);
  }
}
class UserLoginParams{
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password
});


}