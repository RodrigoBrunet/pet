import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:pet/core/network/api_client.dart';
import 'package:pet/features/login/data/datasourses/login_remote_data_source.dart';
import 'package:pet/features/login/data/repositories/login_repository.dart';
import 'package:pet/features/login/data/repositories/login_repository_impl.dart';
import 'package:pet/features/login/domain/usercases/login.dart';
import 'package:pet/features/login/presentation/login_provider.dart';

final sl = GetIt.instance;

void init() {
  // External
  sl.registerLazySingleton(() => Dio());

  // Core
  sl.registerLazySingleton(() => ApiClient(sl<Dio>()));

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));

  // Providers
  sl.registerFactory(() => LoginProvider(loginUseCase: sl()));
}
