import 'package:http/http.dart' as http;
import 'package:weather_test/core/exception/exception.dart';
import 'package:weather_test/domain/entity/city.dart';

class RemoteDataSource {
  RemoteDataSource(this._httpClient);

  final http.Client _httpClient;

  Future<List<String>> getForecast() async {
    try {
      return [];
    } catch (e) {
      throw ServerException(
          message:
              'RemoteDataSource getForecast() exception: ${e.runtimeType}');
    }
  }

  Future<List<City>> getCitiesSuggestion(String query) async {
    try {
      return [
        const City(name: 'Брест', lat: 24, lon: 20),
        const City(name: 'Витебск', lat: 22, lon: 20),
        const City(name: 'Гомель', lat: 21, lon: 20),
        const City(name: 'Гродно', lat: 26, lon: 20),
        const City(name: 'Могилёв', lat: 25, lon: 20),
        const City(name: 'Минск', lat: 23, lon: 20),
      ];
    } catch (e) {
      throw ServerException(
          message:
              'RemoteDataSource getCitiesSuggestion() exception: ${e.runtimeType}');
    }
  }
}
