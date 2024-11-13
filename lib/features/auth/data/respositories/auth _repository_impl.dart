import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRespositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  AuthRespositoryImpl(this.authDataSource);
  @override
  Future<Either<Failure, User>> signInWithEmailPassword(
      {required String email, required String password}) async {
        return _getUser(()async=>await authDataSource.signInWithEmailPassword(
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
      final user = await fun();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
