import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_test/core/constants/request_data.dart';
import 'package:weather_test/domain/entity/city.dart';

class RemoteDataSource {
  RemoteDataSource({required this.httpClient});

  final http.Client httpClient;

  Future<List<City>> getCitiesSuggestion(String query) async {
    final uri = Uri.parse(RequestData.citySearchBaseURL +
        RequestData.apiRequestKey +
        RequestData.apiKey +
        RequestData.cityRequestKey +
        query +
        RequestData.languageRequestKey +
        RequestData.defaultLanguage);

    final response = await httpClient.get(uri);
    final responseJson = jsonDecode(response.body) as List<dynamic>;
    return _filterCitiesByCountry(responseJson);
  }

  Future<List<String>> getForecast() async {
    return [];
  }

  List<City> _filterCitiesByCountry(List<dynamic> response) {
    final filteredCities = response.map((cityJson) {
      if (cityJson[CityResponse.countryKey][CityResponse.countryIDKey] ==
          CityResponse.defaultCountryID) {
        return City(
            name: cityJson[CityResponse.localizedNameKey],
            key: int.parse(cityJson[CityResponse.countryKeyKey]));
      } else {
        return City.empty();
      }
    }).toList();
    filteredCities.removeWhere((city) => city == City.empty());
    return filteredCities;
  }
}
