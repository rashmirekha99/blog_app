part of 'init_dependencies.dart';

final serviceLocator = GetIt.asNewInstance();

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseURL,
    anonKey: SupabaseSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerFactory(() => InternetConnection());
  //core
  serviceLocator.registerFactory<InternetConnectionChecker>(
      () => InternetConnectionCheckerImpl(serviceLocator()));
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  serviceLocator.registerLazySingleton(() => Hive.box(name: 'blogs'));
  serviceLocator.registerLazySingleton(() => UserCubitCubit());
}

void _initAuth() {
//data source
  serviceLocator.registerFactory<AuthDataSource>(
      () => AuthDataSourceImp(serviceLocator()));
//repositories
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRespositoryImpl(serviceLocator(), serviceLocator()));
//usecases
  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignIn(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));
//core

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
  serviceLocator.registerFactory<BlogLocalDataSource>(
      () => BlogLocalDataSourceImp(serviceLocator()));
  //repository
  serviceLocator.registerFactory<BlogRepository>(() => BlogRepositoryImpl(
      blogDataSource: serviceLocator(),
      blogLocalDataSource: serviceLocator(),
      internetConnectionChecker: serviceLocator()));
  //usecase
  serviceLocator.registerFactory(() => AddBlog(serviceLocator()));
  serviceLocator.registerFactory(() => GetBlog(serviceLocator()));
  //Bloc
  serviceLocator.registerLazySingleton(
      () => BlogBloc(addBlog: serviceLocator(), getBlog: serviceLocator()));
}
