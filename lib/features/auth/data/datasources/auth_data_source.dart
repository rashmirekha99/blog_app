import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/user_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDataSource {
  Session? get currentUser;
  Future<UserModels> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModels> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModels?> getCurrentUser();
}

class AuthDataSourceImp implements AuthDataSource {
  //why not create supabase client  here
  //if do this class depend on supabase
  //this way is easy to test
  final SupabaseClient supabaseClient;
  AuthDataSourceImp(this.supabaseClient);
  @override
  Future<UserModels> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModels.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
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

  @override
  // TODO: implement currentUser
  Session? get currentUser => supabaseClient.auth.currentSession;

  @override
  Future<UserModels?> getCurrentUser() async {
    try {
      if (currentUser != null) {
        final user = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUser!.user.id);
        return UserModels.fromJson(user.first);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
