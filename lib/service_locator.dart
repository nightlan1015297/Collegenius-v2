import 'package:collegenius/data/data_sources/auth_providers/auth_provider_factory.dart';
import 'package:collegenius/data/data_sources/crawlers/course_select_crawler.dart';
import 'package:collegenius/data/data_sources/crawlers/eeclass_crawler.dart';
import 'package:collegenius/data/repositories/auth_repository_impl.dart';
import 'package:collegenius/data/repositories/course_select_repository_impl.dart';
import 'package:collegenius/data/repositories/eeclass_repository_impl.dart';
import 'package:collegenius/domain/repositories/auth_repository.dart';
import 'package:collegenius/domain/repositories/course_select_repository.dart';
import 'package:collegenius/domain/repositories/eeclass_repository.dart';
import 'package:collegenius/domain/usecases/get_course_schedule.dart';
import 'package:collegenius/domain/usecases/get_current_semester.dart';
import 'package:collegenius/domain/usecases/get_eeclass_bulletin_content.dart';
import 'package:collegenius/domain/usecases/get_eeclass_course.dart';
import 'package:collegenius/domain/usecases/get_eeclass_course_bulletin_list.dart';
import 'package:collegenius/domain/usecases/get_eeclass_course_list.dart';
import 'package:collegenius/domain/usecases/get_eeclass_course_quiz_list.dart';
import 'package:collegenius/domain/usecases/get_eeclass_semester_list.dart';
import 'package:collegenius/domain/usecases/get_semester_list.dart';
import 'package:collegenius/domain/usecases/login_multiple_service.dart';
import 'package:collegenius/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:collegenius/presentation/bloc/eeclass/eeclass_bloc.dart';
import 'package:collegenius/presentation/bloc/eeclass_bulletins/eeclass_bulletins_bloc.dart';
import 'package:collegenius/presentation/bloc/eeclass_course/eeclass_course_bloc.dart';
import 'package:collegenius/presentation/bloc/eeclass_quizzes/eeclass_quizzes_bloc.dart';
import 'package:collegenius/presentation/bloc/schedule/schedule_bloc.dart';
import 'package:dio/dio.dart';
// ignore: depend_on_referenced_packages
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // Initialize Dio for HTTP requests and CookieJar for session management.
  final dio = Dio();
  // (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
  //     HttpClient()
  //       ..badCertificateCallback =
  //           (X509Certificate cert, String host, int port) => true;
  final cookieJar = CookieJar();

  // Add CookieManager as an interceptor to Dio for managing cookies.
  dio.interceptors.add(CookieManager(cookieJar));

  // Register external dependencies in the service locator.
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => cookieJar);

  // Core: Register AuthProviderFactory to handle authentication with multiple services.
  sl.registerLazySingleton<AuthProviderFactory>(
      () => AuthProviderFactory(dio: sl(), sessionManager: cookieJar));

  // Crawler: Register CourseSelectCrawler to handle web scraping for course selection.
  sl.registerLazySingleton(
      () => CourseSelectCrawler(dio: sl(), sessionManager: cookieJar));
  sl.registerLazySingleton(() => EeclassCrawler(dio: sl()));

  // Repositories: Implement repositories for authentication and course schedule services.
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authProviderFactory: sl()));
  sl.registerLazySingleton<CourseSelectRepository>(() =>
      CourseSelectRepositoryImpl(crsselCrawler: sl(), authRepository: sl()));
  sl.registerLazySingleton<EeclassRepository>(
      () => EeclassRepositoryImpl(authRepository: sl(), eeclassCrawler: sl()));

  // Use Cases: Register the use case for logging into multiple services.
  sl.registerLazySingleton(() => LoginToMultipleServices(sl()));
  sl.registerLazySingleton(() => GetCourseSchedule(repository: sl()));
  sl.registerLazySingleton(() => GetCurrentSemester(repository: sl()));
  sl.registerLazySingleton(() => GetSemesterList(repository: sl()));

  sl.registerLazySingleton(() => GetEeclassCourseList(repository: sl()));
  sl.registerLazySingleton(() => GetEeclassSemesterList(repository: sl()));
  sl.registerLazySingleton(() => GetEeclassCourse(repository: sl()));
  sl.registerLazySingleton(() => GetEeclassBulletinContent(repository: sl()));
  sl.registerLazySingleton(() => GetEeclassCourseBulletinList(repository: sl()));
  sl.registerLazySingleton(() => GetEeclassCourseQuizList(repository: sl()));

  // Blocs: Register AuthBloc to manage authentication state in the app.
  sl.registerFactory(() => AuthBloc(loginToMultipleServices: sl()));
  sl.registerFactory(
    () => ScheduleBloc(
        getCourseSchedule: sl(),
        getCurrentSemester: sl(),
        getSemesterList: sl()),
  );
  sl.registerFactory(
    () => EeclassBloc(
      getEeclassCourseList: sl(),
      getEeclassSemesterList: sl(),
    ),
  );
  sl.registerFactory(
    () => EeclassCourseBloc(
      getEeclassBulletin: sl(),
      getEeclassBulletinList: sl(),
      getEeclassCourse: sl(),
    ),
  );
  sl.registerFactory(
    () => EeclassQuizzesBloc(
      getEeclassCourseQuizList: sl(),
    ),
  );
   sl.registerFactory(
    () => EeclassBulletinsBloc(
      getEeclassBulletinList: sl(),
    ),
  );
}
