// ignore_for_file: void_checks

import 'package:dartz/dartz.dart';
import 'package:weather_test/core/exception/exception.dart';
import 'package:weather_test/core/exception/failure.dart';
import 'package:weather_test/data/datasource/local_datasource.dart';
import 'package:weather_test/data/datasource/remote_datasource.dart';
import 'package:weather_test/domain/entity/city.dart';
import 'package:weather_test/domain/entity/forecast.dart';

class AppRepository {
  AppRepository(
    this._remoteDataSource,
    this._localDataSource,
  );

  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;

  Future<Either<ServerFailure, List<City>>> getRemoteCities(String query) async {
    try {
      final cities = await _remoteDataSource.getCitiesSuggestion(query);
      return Right(cities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  Future<Either<ServerFailure, List<Forecast>>> getRemoteForecasts(City city) async {
    try {
      final forecasts = await _remoteDataSource.getForecasts(city);
      return Right(forecasts);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  Future<Either<CacheFailure, City>> getSavedCity() async {
    try {
      final city = await _localDataSource.getCity();
      return Right(city);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  Future<Either<CacheFailure, List<Forecast>>> getSavedForecasts() async {
    try {
      final forecasts = await _localDataSource.getForecasts();
      return Right(forecasts);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  Future<Either<CacheFailure, void>> saveCity(City city) async {
    try {
      await _localDataSource.saveCity(city);
      return Right(Future.value());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  Future<Either<CacheFailure, void>> saveForecasts(List<Forecast> forecasts) async {
    try {
      await _localDataSource.saveForecasts(forecasts);

      return Right(Future.value());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
