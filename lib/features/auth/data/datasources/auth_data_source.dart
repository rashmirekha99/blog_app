import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/user_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDataSource {
  Future<UserModels> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModels> signInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthDataSourceImp implements AuthDataSource {
  //why not create supabase client  here
  //if do this class depend on supabase
  //this way is easy to test
  final SupabaseClient supabaseClient;
  AuthDataSourceImp(this.supabaseClient);
  @override
  Future<UserModels> signInWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<UserModels> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
     
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {
        'name': name,
      });
     
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModels.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
