import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecases/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogOut implements UseCase<bool, NoParams> {
  final AuthRepository authRepository;
  UserLogOut(this.authRepository);
  
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await authRepository.logOut();
  }
}
