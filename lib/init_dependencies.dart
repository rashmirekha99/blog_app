import 'package:blog_app/core/common/cubits/user_cubit/user_cubit_cubit.dart';
import 'package:blog_app/core/secrets/supabase_secrets.dart';
import 'package:blog_app/features/auth/data/datasources/auth_data_source.dart';
import 'package:blog_app/features/auth/data/respositories/auth%20_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasource/blog_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/add_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.asNewInstance();

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseURL,
    anonKey: SupabaseSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
//data source
  serviceLocator.registerFactory<AuthDataSource>(
      () => AuthDataSourceImp(serviceLocator()));
//repositories
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRespositoryImpl(serviceLocator()));
//usecases
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignIn(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));
//core
  serviceLocator.registerLazySingleton(() => UserCubitCubit());
//Bloc
  serviceLocator.registerLazySingleton(() => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
      userCubit: serviceLocator()));
}

void _initBlog() {
  //datasources
  serviceLocator.registerFactory<BlogDataSource>(
      () => BlogDataSourceImpl(serviceLocator()));
  //repository
  serviceLocator.registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator()));
  //usecase
  serviceLocator.registerFactory(
    () => AddBlog(serviceLocator()),
  );
  //Bloc
  serviceLocator
      .registerLazySingleton(() => BlogBloc(addBlog: serviceLocator()));
}
