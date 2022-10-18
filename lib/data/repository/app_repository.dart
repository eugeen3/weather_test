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

  Future<Either<Failure, List<City>>> getCities(String query) async {
    try {
      final cities = await _remoteDataSource.getCitiesSuggestion(query);
      return Right(cities);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  Future<Either<Failure, City>> getSavedCity() async {
    try {
      final city = await _localDataSource.getCity();
      return Right(city);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }

  Future<Either<Failure, List<Forecast>>> getSavedForecasts() async {
    try {
      final forecasts = await _localDataSource.getForecasts();
      return Right(forecasts);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    }
  }
}
