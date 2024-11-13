
import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_models.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class AuthRespositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  AuthRespositoryImpl(this.authDataSource);
  @override
  Future<Either<Failure, User>> signInWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user=await authDataSource.signUpWithEmailPassword(
          email: email, password: password, name: name);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
