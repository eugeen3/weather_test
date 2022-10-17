import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_test/data/datasource/local_datasource.dart';
import 'package:weather_test/data/datasource/remote_datasource.dart';
import 'package:weather_test/data/repository/app_repository.dart';
import 'package:weather_test/presentation/cubit/app_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  http.Client httpClient = http.Client();
  sl.registerSingleton<http.Client>(httpClient);

  sl.registerSingleton<RemoteDataSource>(RemoteDataSource(httpClient: sl()));
  sl.registerSingleton<LocalDataSource>(
      LocalDataSource(sharedPreferences: sl()));

  sl.registerSingleton<AppRepository>(AppRepository(
    remoteDataSource: sl(),
    localDataSource: sl(),
  ));

  sl.registerSingleton<AppCubit>(AppCubit(sl()));
}
