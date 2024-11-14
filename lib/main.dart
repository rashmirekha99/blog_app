import 'package:blog_app/core/common/cubits/user_cubit/user_cubit_cubit.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blog/presentation/pages/add_blogs_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => serviceLocator<AuthBloc>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<UserCubitCubit>(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthCurrentUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<UserCubitCubit, UserCubitState, bool>(
        selector: (state) {
          return state is AppUserState;
        },
        //if true run this builder
        builder: (context, state) {
          if (state) {
            return const BlogPage();
          }
          return const SignInPage();
        },
      ),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/add_new_blog':(context)=>const AddNewBlog(),
      },
    );
  }
}
