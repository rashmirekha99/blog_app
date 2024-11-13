import 'package:blog_app/core/secrets/supabase_secrets.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:blog_app/features/auth/data/respositories/auth%20_repository_impl.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseURL,
    anonKey: SupabaseSecrets.supabaseAnonKey,
  );
  

  // print(supabase.client.accessToken.toString());
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => AuthBloc(
        userSignUp: UserSignUp(
          AuthRespositoryImpl(
            AuthDataSourceImp(supabase.client),
          ),
        ),
      ),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const SignInPage(),
      routes: {'/signup': (context) => const SignUpPage()},
    );
  }
}
