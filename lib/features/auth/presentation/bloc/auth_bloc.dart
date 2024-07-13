import 'package:blogapp/features/auth/domain/usecases/current_user.dart';
import 'package:blogapp/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blogapp/features/auth/domain/usecases/user_login.dart';
import 'package:blogapp/features/auth/domain/usecases/user_logout.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/Cubits/app_user_cubit.dart';
import 'package:blogapp/core/common/entities/user.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final userSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentuser;
  final AppUserCubit _appUserCubit;
  final UserLogout _userLogout;

  AuthBloc({
    required userSignUp UserSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required UserLogout userLogout
  }) : _userSignUp = UserSignUp,
  _userLogin = userLogin,
  _currentuser = currentUser,
  _appUserCubit = appUserCubit,
  _userLogout = userLogout,
        super(AuthInitial()) {
    on<AuthEvent>((_,emit)=>emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignup);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthLogout>(_onAuthLogout);
  }

  void _isUserLoggedIn(AuthIsUserLoggedIn event,Emitter<AuthState> emit)async{
    final res = await _currentuser(noParams());

    res.fold(
            (l)=>emit(AuthFailure(l.message)),
            (r){
              print(r.email);
              _emitAuthSuccess(r,emit);});
  }

  void _onAuthSignup(AuthSignUp event,Emitter<AuthState> emit) async{

    final res = await _userSignUp(userSignUpParams(
        email: event.email,
        name: event.name,
        pass: event.pass));

    res.fold((l)=>emit(AuthFailure(l.message)),
            (user)=>_emitAuthSuccess(user,emit));
  }

  void _onAuthLogin(AuthLogin event,Emitter<AuthState> emit) async {


    final res = await _userLogin(UserLoginParams(
        email: event.email,
        password: event.password));

    res.fold((l)=>emit(AuthFailure(l.message)),
            (user) =>_emitAuthSuccess(user,emit));

    //print(event.email+" Test login");

  }

  void _emitAuthSuccess(
      User user,
      Emitter<AuthState> emit)
  {
    _appUserCubit.updateuser(user);
    // _isUserLoggedIn(event, emit)
    emit(AuthSuccess(user));
}

  void _onAuthLogout(
      AuthLogout event,
      Emitter<AuthState> emit,

      ){

    _userLogout;

  }
}
