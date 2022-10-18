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
  static const String defaultLimit5 = '5';
}

abstract class CityResponse {
  static const String defaultCountryID = 'BY';
  static const String countryKey = 'Country';
  static const String countryIDKey = 'ID';
  static const String localizedNameKey = 'LocalizedName';
  static const String countryKeyKey = 'Key';
}
