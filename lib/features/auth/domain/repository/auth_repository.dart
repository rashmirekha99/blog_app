import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  //signUpWithEmailPassword
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  //signInWithEmailPassword
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  //getCurrentUser
  Future<Either<Failure, User>> currentUser();
  //log out user
  Future<Either<Failure, bool>> logOut();
}
