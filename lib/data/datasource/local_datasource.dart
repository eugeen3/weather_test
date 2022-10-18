import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_test/core/constants/strings.dart';
import 'package:weather_test/core/exception/exception.dart';
import 'package:weather_test/domain/entity/city.dart';
import 'package:weather_test/domain/entity/forecast.dart';

class LocalDataSource {
  LocalDataSource(this._sharedPreferences);

  static const String _cityKey = 'city';
  static const String _forecastsKey = 'forecasts';

  final SharedPreferences _sharedPreferences;

  Future<void> saveCity(City city) async {
    try {
      final cityJson = city.toJson();
      _sharedPreferences.setString(_cityKey, cityJson);
    } catch (e) {
      throw CacheException(message: 'LocalDataSource saveCity() exception: $e');
    }
  }

  Future<void> saveForecasts(List<Forecast> forecasts) async {
    try {
      final forecastsJson = jsonEncode(forecasts);
      _sharedPreferences.setString(_forecastsKey, forecastsJson);
    } catch (e) {
      throw CacheException(message: 'LocalDataSource saveForecasts() exception: $e');
    }
  }

  Future<City> getCity() async {
    try {
      final cityJson = _sharedPreferences.getString(_cityKey);
      if (cityJson != null) {
        return City.fromJson(cityJson);
      } else {
        throw CacheException(message: StringContsants.savedCityError);
      }
    } catch (e) {
      throw CacheException(message: 'LocalDataSource getCity() exception: $e');
    }
  }

  Future<List<Forecast>> getForecasts() async {
    try {
      final forecastsJson = _sharedPreferences.getString(_forecastsKey);
      if (forecastsJson != null) {
        final forecasts = jsonDecode(forecastsJson) as List<dynamic>;
        return forecasts.map((forecast) => Forecast.fromMapLocal(jsonDecode(forecast))).toList();
      } else {
        throw CacheException(message: StringContsants.savedForecastsError);
      }
    } catch (e) {
      throw CacheException(message: 'LocalDataSource getForecasts() exception: $e');
    }
  }
}
