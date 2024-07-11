import 'package:blogapp/core/error/exceptions.dart';
import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/features/auth/data/data%20sources/auth_remote_data_source.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';

import 'package:fpdart/fpdart.dart';


import '../../../../core/common/entities/user.dart';

class AuthRepositoryImpl implements authRepository{
  final authRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPass({required String email, required String pass}) async{
    try{
        final user =  await remoteDataSource.loginWithEmailPassword(
            email: email,
            pass: pass);

        return right(user);
    }on ServerException catch(e){
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPass({
    required String email,
    required String name,
    required String pass}) async{
    try{
        final user = await remoteDataSource.signUpWithEmailPassword(
            email: email,
            name: name,
            pass: pass);

        // final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        //     email: email,
        //     password: pass,
        // );
        return right(user);
      //return right(user.user!.uid);
    }
    on ServerException catch(e){
        return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async{
    try{
      final user = await remoteDataSource.getCurrentUserData();

      if(user==null){
        return left(Failure("user not logged in"));
      }

      return right(user);
    }on ServerException catch(e){
      return left(Failure(e.message));
    }
  }
  
}