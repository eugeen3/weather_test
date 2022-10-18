import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_test/core/constants/request_data.dart';

class Forecast extends Equatable {
  const Forecast({
    required this.date,
    required this.temperature,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
  });

  final DateTime date;
  final double temperature;
  final double feelsLike;
  final double pressure;
  final double humidity;
  final double windSpeed;

  Forecast copyWith({
    DateTime? date,
    double? temperature,
    double? feelsLike,
    double? pressure,
    double? humidity,
    double? windSpeed,
  }) {
    return Forecast(
      date: date ?? this.date,
      temperature: temperature ?? this.temperature,
      feelsLike: feelsLike ?? this.feelsLike,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ForecastResponse.date: date.millisecondsSinceEpoch,
      ForecastResponse.temperature: temperature,
      ForecastResponse.feelsLike: feelsLike,
      ForecastResponse.pressure: pressure,
      ForecastResponse.humidity: humidity,
      '${ForecastResponse.windInfo}${ForecastResponse.windSpeed}': windSpeed,
    };
  }

  factory Forecast.fromMapLocal(Map<String, dynamic> map) {
    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch(
          map[ForecastResponse.date] as int),
      temperature: map[ForecastResponse.temperature] as double,
      feelsLike: map[ForecastResponse.feelsLike] as double,
      pressure: map[ForecastResponse.pressure] as double,
      humidity: map[ForecastResponse.humidity] as double,
      windSpeed:
          map['${ForecastResponse.windInfo}${ForecastResponse.windSpeed}']
              as double,
    );
  }

  factory Forecast.fromMapResponse(Map<String, dynamic> map) {
    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch(
          map[ForecastResponse.date] as int),
      temperature: map[ForecastResponse.mainInfo][ForecastResponse.temperature]
          as double,
      feelsLike:
          map[ForecastResponse.mainInfo][ForecastResponse.feelsLike] as double,
      pressure:
          map[ForecastResponse.mainInfo][ForecastResponse.pressure] as double,
      humidity:
          map[ForecastResponse.mainInfo][ForecastResponse.humidity] as double,
      windSpeed:
          map[ForecastResponse.windInfo][ForecastResponse.windSpeed] as double,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [
      date,
      temperature,
      feelsLike,
      pressure,
      humidity,
      windSpeed,
    ];
  }

  @override
  bool get stringify => true;
}
