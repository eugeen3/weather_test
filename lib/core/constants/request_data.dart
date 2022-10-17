abstract class RequestData {
  static const String citySearchBaseURL =
      'http://dataservice.accuweather.com/locations/v1/cities/search';
  static const String forecastBaseURL =
      'http://dataservice.accuweather.com/forecasts/v1/daily/5day/';
  static const String apiKey = 'hmpCGuXtk3DbuULj2lR42IRE7EraetTf';
  static const String apiRequestKey = '?apikey=';
  static const String cityRequestKey = '&q=';
  static const String languageRequestKey = '&language=';
  static const String defaultLanguage = 'ru-ru';
}

abstract class CityResponse {
  static const String defaultCountryID = 'BY';
  static const String countryKey = 'Country';
  static const String countryIDKey = 'ID';
  static const String localizedNameKey = 'LocalizedName';
  static const String countryKeyKey = 'Key';
}
