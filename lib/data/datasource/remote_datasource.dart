import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_test/core/constants/request_data.dart';
import 'package:weather_test/core/exception/exception.dart';
import 'package:weather_test/domain/entity/city.dart';
import 'package:weather_test/domain/entity/forecast.dart';

class RemoteDataSource {
  RemoteDataSource(this._httpClient);

  final http.Client _httpClient;

  Future<List<Forecast>> getForecasts(City city, [int days = 3]) async {
    const int hourForNextDaysForecasts = 12;

    try {
      final uri = Uri.parse(
        RequestData.forecastBaseURL +
            RequestData.latKey +
            city.lat.toString() +
            RequestData.lonKey +
            city.lon.toString() +
            RequestData.unitsKey +
            RequestData.defaultUnits +
            RequestData.apiRequestKey +
            RequestData.apiKey,
      );

      final response = await _httpClient.get(uri);
      final responseJson = jsonDecode(response.body);
      final responseListJson = responseJson[ForecastResponse.listName] as List<dynamic>;

      if (responseListJson.isEmpty) {
        return [];
      } else {
        final allForecasts =
            responseListJson.map((forecastJson) => Forecast.fromMapResponse(forecastJson)).toList();
        final List<Forecast> filteredForcasts = [];

        final todaysForecast = allForecasts.first;
        filteredForcasts.add(todaysForecast);

        int currentDay = todaysForecast.date.day;
        for (int i = 0, addedDays = 0; i < allForecasts.length && addedDays < days; i++) {
          if (allForecasts[i].date.day != currentDay &&
              allForecasts[i].date.hour == hourForNextDaysForecasts) {
            filteredForcasts.add(allForecasts[i]);
            addedDays++;
          }
        }
        return filteredForcasts;
      }
    } catch (e) {
      throw ServerException(
          message: 'RemoteDataSource getForecasts() exception: ${e.runtimeType}, $e');
    }
  }

  Future<List<City>> getCitiesSuggestion(String query) async {
    try {
      final uri = Uri.parse(
        RequestData.citySearchBaseURL +
            RequestData.cityRequestKey +
            query +
            RequestData.querySeparator +
            RequestData.defaultCountryID +
            RequestData.limitRequestKey +
            RequestData.defaultLimit +
            RequestData.apiRequestKey +
            RequestData.apiKey,
      );

      final response = await _httpClient.get(uri);
      final responseJson = jsonDecode(response.body) as List<dynamic>;
      if (responseJson.isEmpty) {
        return [];
      } else {
        return responseJson.map((cityJson) => City.fromMap(cityJson, fromRequest: true)).toList();
      }
    } catch (e) {
      throw ServerException(
          message: 'RemoteDataSource getCitiesSuggestion() exception: ${e.runtimeType}');
    }
  }
}
