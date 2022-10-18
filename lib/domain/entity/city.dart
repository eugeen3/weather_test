import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_test/core/constants/request_data.dart';

class City extends Equatable {
  const City({
    required this.name,
    this.state,
    required this.lat,
    required this.lon,
  });

  final String name;
  final String? state;
  final double lat;
  final double lon;

  City copyWith({
    String? name,
    String? state,
    double? lat,
    double? lon,
  }) {
    return City(
      name: name ?? this.name,
      state: state ?? this.state,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CityResponse.name: name,
      CityResponse.state: state,
      CityResponse.lat: lat,
      CityResponse.lon: lon,
    };
  }

  factory City.fromMap(Map<String, dynamic> map, {bool fromRequest = false}) {
    return City(
      name: fromRequest
          ? map[CityResponse.localNames][CityResponse.locale] as String
          : map[CityResponse.name],
      state: map[CityResponse.state] != null
          ? map[CityResponse.state] as String
          : null,
      lat: map[CityResponse.lat] as double,
      lon: map[CityResponse.lon] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) =>
      City.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [name, state, lat, lon];

  @override
  bool get stringify => true;
}
