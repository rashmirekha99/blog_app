import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRespositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  AuthRespositoryImpl(this.authDataSource);
  @override
  Future<Either<Failure, String>> signInWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userId=await authDataSource.signUpWithEmailPassword(
          email: email, password: password, name: name);
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
