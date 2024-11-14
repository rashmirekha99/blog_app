import 'package:blog_app/core/common/entities/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_cubit_state.dart';

class UserCubitCubit extends Cubit<UserCubitState> {
  UserCubitCubit() : super(UserCubitInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(UserCubitInitial());
    } else {
      emit(AppUserState(user));
    }
  }
}
