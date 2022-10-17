import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:weather_test/core/constants/request_data.dart';

class City extends Equatable {
  const City({
    required this.name,
    required this.key,
  });

  final String name;
  final int key;

  City copyWith({
    String? name,
    int? key,
  }) {
    return City(
      name: name ?? this.name,
      key: key ?? this.key,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CityResponse.localizedNameKey: name,
      CityResponse.countryKeyKey: key,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      name: map[CityResponse.localizedNameKey] as String,
      key: map[CityResponse.countryKeyKey] as int,
    );
  }

  factory City.empty() {
    return const City(
      name: '',
      key: 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) =>
      City.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'City(name: $name, key: $key)';

  @override
  List<Object?> get props => [name, key];
}
