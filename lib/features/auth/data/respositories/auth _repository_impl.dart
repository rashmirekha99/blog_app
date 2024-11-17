
import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/network/internet_connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/data/models/user_models.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRespositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final InternetConnectionChecker internetChecker;
  AuthRespositoryImpl(this.authDataSource, this.internetChecker);
  @override
  Future<Either<Failure, User>> signInWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await authDataSource.signInWithEmailPassword(
        email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async => await authDataSource.signUpWithEmailPassword(
        email: email, password: password, name: name));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fun) async {
    try {
      final isConnected = await internetChecker.getInternetConnection();
      if (!isConnected) {
        return left(Failure(Constant.notHaveInternetConnectionMsg));
      }
      final user = await fun();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      //when offline
      if (!await internetChecker.getInternetConnection()) {
        if (authDataSource.currentUser == null) {
          return left(Failure('User Not Logged In'));
        }
        //return last logged user status
        final currentUser = authDataSource.currentUser;
        final currentUserData = UserModels(
            email: currentUser?.user.email ?? '',
            id: currentUser?.user.id ?? '',
            name: '');

        return right(currentUserData);
      }
      //when online
      //return logged status from remote data source
      final user = await authDataSource.getCurrentUser();
      if (user == null) {
        return left(Failure('User Not Logged In'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> logOut() async {
    try {
      if (!await internetChecker.getInternetConnection()) {
        return left(Failure(Constant.notHaveInternetConnectionMsg));
      }
      await authDataSource.logOutCurrentUser();
      return right(true);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
