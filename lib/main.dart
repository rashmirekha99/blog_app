import 'package:blog_app/core/common/cubits/user_cubit/user_cubit_cubit.dart';
import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/core/constant/routes.dart';
import 'package:blog_app/core/pages/not_found_page.dart';
import 'package:blog_app/core/theme/bloc/theme_bloc.dart';
import 'package:blog_app/core/theme/dark_theme.dart';
import 'package:blog_app/core/theme/light_theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_page.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/home_page.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.initialize('b1ebfbc5-178d-4697-9692-9c0acd22d82f');
  await initDependencies();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => serviceLocator<AuthBloc>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<UserCubitCubit>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<BlogBloc>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<ThemeBloc>(),
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
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Constant.appName,
          themeMode: state,
          darkTheme: DarkThemeData.darkThemeMode,
          theme: LightThemeData.lightThemeMode,
          home: BlocSelector<UserCubitCubit, UserCubitState, bool>(
            selector: (state) {
              return state is AppUserState;
            },
            //if true run this builder
            builder: (context, state) {
              if (state) {
                return const HomePage();
              }
              return const SignInPage();
            },
          ),
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case RouteNames.initialRouteName:
                return MaterialPageRoute(
                    builder: (context) => const HomePage());
              case RouteNames.signUpRouteName:
                return MaterialPageRoute(
                    builder: (context) => const SignUpPage());
              case RouteNames.signInRouteName:
                return MaterialPageRoute(
                    builder: (context) => const SignInPage());
              default:
                return MaterialPageRoute(
                    builder: (context) => const NotFoundPage());
            }
          },
        );
      },
    );
  }
}
