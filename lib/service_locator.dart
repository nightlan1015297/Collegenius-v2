import 'package:collegenius/data/data_sources/auth_providers/auth_provider_factory.dart';
import 'package:collegenius/data/data_sources/crawlers/course_select_crawler.dart';
import 'package:collegenius/data/repositories/auth_repository_impl.dart';
import 'package:collegenius/data/repositories/course_select_repository_impl.dart'; 
import 'package:collegenius/domain/repositories/auth_repository.dart';
import 'package:collegenius/domain/repositories/course_select_repository.dart';
import 'package:collegenius/domain/usecases/get_course_schedule.dart';
import 'package:collegenius/domain/usecases/get_current_semester.dart';
import 'package:collegenius/domain/usecases/get_semester_list.dart';
import 'package:collegenius/domain/usecases/login_multiple_service.dart';
import 'package:collegenius/presentation/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // Initialize Dio for HTTP requests and CookieJar for session management.
  final dio = Dio();
  final cookieJar = CookieJar();
  
  // Add CookieManager as an interceptor to Dio for managing cookies.
  dio.interceptors.add(CookieManager(cookieJar));

  // Register external dependencies in the service locator.
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => cookieJar);
  
  // Core: Register AuthProviderFactory to handle authentication with multiple services.
  sl.registerLazySingleton<AuthProviderFactory>(() => AuthProviderFactory(dio: sl(), sessionManager: cookieJar));
  
  // Crawler: Register CourseSelectCrawler to handle web scraping for course selection.
  sl.registerLazySingleton(() => CourseSelectCrawler(dio: sl(), sessionManager: cookieJar));
  
  // Repositories: Implement repositories for authentication and course schedule services.
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(authProviderFactory: sl()));
  sl.registerLazySingleton<CourseSelectRepository>(() => CourseSelectRepositoryImpl(crsselCrawler: sl(), authRepository: sl())); 
  
  // Use Cases: Register the use case for logging into multiple services.
  sl.registerLazySingleton(() => LoginToMultipleServices(sl()));
  sl.registerLazySingleton(() => GetCourseSchedule(repository:sl()));
  sl.registerLazySingleton(() => GetCurrentSemester(repository:sl()));
  sl.registerLazySingleton(() => GetSemesterList(repository:sl()));
  
  // Blocs: Register AuthBloc to manage authentication state in the app.
  sl.registerFactory(() => AuthBloc(loginToMultipleServices: sl()));
}
