import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_test/core/exception/exception.dart';
import 'package:weather_test/domain/entity/city.dart';
import 'package:weather_test/domain/entity/forecast.dart';

class LocalDataSource {
  LocalDataSource(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  Future<void> saveCity(City city) async {}

  Future<void> saveForecasts(List<Forecast> forecasts) async {}

  Future<City> getCity() async {
    try {
      return const City(name: '', lat: 2, lon: 2);
    } catch (e) {
      throw CacheException(
          message: 'LocalDataSource getCity() exception: ${e.runtimeType}');
    }
  }

  Future<List<Forecast>> getForecasts() async {
    try {
      return [];
    } catch (e) {
      throw CacheException(
          message:
              'LocalDataSource getForecasts() exception: ${e.runtimeType}');
    }
  }
}
