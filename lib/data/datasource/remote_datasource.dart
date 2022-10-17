abstract class RemoteDataSource {
  Future<List<String>> getCitiesSuggestion();
  Future<List<String>> getForecast();
}
