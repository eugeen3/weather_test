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
    final forecastsCount = days * RequestData.amountOfForecastsForOneDay;

    try {
      final uri = Uri.parse(
        RequestData.forecastBaseURL +
            RequestData.latKey +
            city.lat.toString() +
            RequestData.lonKey +
            city.lon.toString() +
            RequestData.unitsKey +
            RequestData.defaultUnits +
            RequestData.amountOfForecasts +
            forecastsCount.toString() +
            RequestData.apiRequestKey +
            RequestData.apiKey,
      );

      final response = await _httpClient.get(uri);
      final responseJson = jsonDecode(response.body);
      final responseListJson =
          responseJson[ForecastResponse.listName] as List<dynamic>;

      if (responseListJson.isEmpty) {
        return [];
      } else {
        return responseListJson
            .map((forecastJson) => Forecast.fromMapResponse(forecastJson))
            .toList();
      }
    } catch (e) {
      throw ServerException(
          message:
              'RemoteDataSource getForecasts() exception: ${e.runtimeType}');
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
        return responseJson
            .map((cityJson) => City.fromMap(cityJson, fromRequest: true))
            .toList();
      }
    } catch (e) {
      throw ServerException(
          message:
              'RemoteDataSource getCitiesSuggestion() exception: ${e.runtimeType}');
    }
  }
}
