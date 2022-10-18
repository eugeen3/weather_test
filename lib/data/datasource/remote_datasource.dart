import 'package:http/http.dart' as http;
import 'package:weather_test/domain/entity/city.dart';

class RemoteDataSource {
  RemoteDataSource({required this.httpClient});

  final http.Client httpClient;

  Future<List<String>> getForecast() async {
    return [];
  }

  Future<List<City>> getCitiesSuggestion(String query) async {
    return [
      const City(name: 'Брест', lat: 24, lon: 20),
      const City(name: 'Витебск', lat: 22, lon: 20),
      const City(name: 'Гомель', lat: 21, lon: 20),
      const City(name: 'Гродно', lat: 26, lon: 20),
      const City(name: 'Могилёв', lat: 25, lon: 20),
      const City(name: 'Минск', lat: 23, lon: 20),
    ];
  }
}
