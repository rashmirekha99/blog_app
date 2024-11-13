import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
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
}
