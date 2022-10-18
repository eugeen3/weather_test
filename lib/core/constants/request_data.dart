abstract class RequestData {
  static const String citySearchBaseURL =
      'http://api.openweathermap.org/geo/1.0/direct';
  static const String forecastBaseURL =
      'https://api.openweathermap.org/data/2.5/forecast';
  static const String apiKey = '15012b653b24cfbe43a598e29c0118bf';
  static const String apiRequestKey = '&appid=';
  static const String cityRequestKey = '?q=';
  static const String defaultCountryID = 'BY';
  static const String limitRequestKey = '&limit=';
  static const String defaultLimit = '5';
  static const String querySeparator = ',';
  static const String latKey = '?lat=';
  static const String lonKey = '&lon=';
  static const String unitsKey = '&units=';
  static const String defaultUnits = 'metric';
  static const String amountOfForecasts = '&cnt=';
  static const int amountOfForecastsForOneDay = 8;
}

abstract class CityResponse {
  static const String localNames = 'local_names';
  static const String locale = 'ru';
  static const String name = 'name';
  static const String state = 'state';
  static const String lat = 'lat';
  static const String lon = 'lon';
}

abstract class ForecastResponse {
  static const String listName = 'list';
  static const String date = 'dt_txt';
  static const String mainInfo = 'main';
  static const String temperature = 'temp';
  static const String feelsLike = 'feels_like';
  static const String pressure = 'pressure';
  static const String humidity = 'humidity';
  static const String windInfo = 'wind';
  static const String windSpeed = 'speed';
}
