import 'package:blog_app/core/common/cubits/user_cubit/user_cubit_cubit.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final UserCubitCubit _userCubit;
  AuthBloc(
      {required UserSignUp userSignUp,
      required UserSignIn userSignIn,
      required CurrentUser currentUser,
      required UserCubitCubit userCubit})
      : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _userCubit = userCubit,
        super(AuthInitial()) {
    //automaticslly add loading begining of an emit
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    //Sign up
    on<AuthSignUp>(
      (event, emit) async {
        
        final res = await _userSignUp(
          UserSignUpParams(
            email: event.email,
            name: event.name,
            password: event.password,
          ),
        );
        res.fold((l) => emit(AuthFailure(l.message)),
            (r) => _emitAuthSucess(r, emit));
      },
    );
    //Sign in
    on<AuthSignIn>(
      (event, emit) async {
     
        final res = await _userSignIn(
          UserSignInParams(
            email: event.email,
            password: event.password,
          ),
        );
        res.fold((l) => emit(AuthFailure(l.message)),
            (r) => _emitAuthSucess(r, emit));
      },
    );
    //current User

    on<AuthCurrentUser>(
      (event, emit) async {
        
        final res = await _currentUser(NoParams());
        res.fold((l) => emit(AuthFailure(l.message)),
            (r) => _emitAuthSucess(r, emit));
      },
    );
  }

  //
  void _emitAuthSucess(User user, Emitter<AuthState> emit) {
    _userCubit.updateUser(user);
    emit(AuthSucess(user));
  }
}
