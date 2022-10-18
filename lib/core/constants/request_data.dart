abstract class RequestData {
  static const String citySearchBaseURL =
      'http://api.openweathermap.org/geo/1.0/direct';
  static const String forecastBaseURL =
      'https://api.openweathermap.org/data/3.0/onecall';
  static const String apiKey = '15012b653b24cfbe43a598e29c0118bf';
  static const String apiRequestKey = '&appid=';
  static const String cityRequestKey = '&q=';
  static const String defaultCountryID = 'BY';
  static const String limitRequestKey = '&limit=';
  static const String defaultLimit = '5';
  static const String querySeparator = ',';
}

abstract class CityResponse {
  static const String localNames = 'local_names';
  static const String locale = 'ru';
  static const String name = 'name';
  static const String lat = 'lat';
  static const String lon = 'lon';
}
