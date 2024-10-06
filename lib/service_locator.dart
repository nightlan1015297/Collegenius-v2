import 'package:collegenius/data/data_sources/auth_providers/auth_provider_factory.dart';
import 'package:collegenius/data/data_sources/crawlers/course_select_crawler.dart';
import 'package:collegenius/data/repositories/auth_repository_impl.dart';
import 'package:collegenius/data/repositories/course_schedual_repository_impl.dart';
import 'package:collegenius/domain/repositories/auth_repository.dart';
import 'package:collegenius/domain/repositories/course_schedual_repository.dart';
import 'package:collegenius/domain/usecases/login_multiple_service.dart';
import 'package:collegenius/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  final dio = Dio();
  final cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));

  // External dependencies
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => cookieJar);
  
  // Core
  sl.registerLazySingleton<AuthProviderFactory>(() => AuthProviderFactory(dio:sl(), sessionManager:cookieJar));
  // Crawler
  sl.registerLazySingleton(() => CourseSelectCrawler(dio:sl()));
  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authProviderFactory:sl()));
  sl.registerLazySingleton<CourseSchedualRepository>(() => CourseSchedualRepositoryImpl(crsselCrawler:sl(), authRepository:sl()));
  // Use Cases
  sl.registerLazySingleton(() => LoginToMultipleServices(sl()));
  // Blocs
  sl.registerFactory(() => AuthBloc(loginToMultipleServices: sl()));
  
}