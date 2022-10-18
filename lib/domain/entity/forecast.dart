// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

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
      'date': date.millisecondsSinceEpoch,
      'temperature': temperature,
      'feelsLike': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'windSpeed': windSpeed,
    };
  }

  factory Forecast.fromMap(Map<String, dynamic> map) {
    return Forecast(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      temperature: map['temperature'] as double,
      feelsLike: map['feelsLike'] as double,
      pressure: map['pressure'] as double,
      humidity: map['humidity'] as double,
      windSpeed: map['windSpeed'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Forecast.fromJson(String source) =>
      Forecast.fromMap(json.decode(source) as Map<String, dynamic>);

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
