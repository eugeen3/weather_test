import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_test/core/constants/request_data.dart';

class Forecast extends Equatable {
  const Forecast({
    required this.date,
    required this.temperature,
  });

  final DateTime date;
  final double temperature;

  Forecast copyWith({
    DateTime? date,
    double? temperature,
  }) {
    return Forecast(
      date: date ?? this.date,
      temperature: temperature ?? this.temperature,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ForecastResponse.date: date.millisecondsSinceEpoch,
      ForecastResponse.temperature: temperature,
    };
  }

  factory Forecast.fromMapLocal(Map<String, dynamic> map) {
    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch(map[ForecastResponse.date] as int),
      temperature: map[ForecastResponse.temperature] as double,
    );
  }

  factory Forecast.fromMapResponse(Map<String, dynamic> map) {
    return Forecast(
      date: DateTime.parse(map[ForecastResponse.date] as String),
      temperature: map[ForecastResponse.mainInfo][ForecastResponse.temperature] as double,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object> get props {
    return [
      date,
      temperature,
    ];
  }

  @override
  bool get stringify => true;
}
