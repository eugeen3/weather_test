import 'package:weather_test/data/datasource/local_datasource.dart';
import 'package:weather_test/data/datasource/remote_datasource.dart';
import 'package:weather_test/domain/entity/city.dart';

class AppRepository {
  AppRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  Future<List<City>> getCities(String query) {
    return remoteDataSource.getCitiesSuggestion(query);
  }
}
