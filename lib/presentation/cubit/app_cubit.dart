import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/core/constants/strings.dart';
import 'package:weather_test/data/repository/app_repository.dart';
import 'package:weather_test/domain/entity/city.dart';
import 'package:weather_test/domain/entity/forecast.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._appRepository) : super(const AppState());

  final AppRepository _appRepository;

  Future<List<City>> getCities(String query) async {
    final List<City> citiesList = [];
    final cities = await _appRepository.getRemoteCities(query);
    cities.fold((error) {
      debugPrint(error.message);
    }, (cities) => citiesList.addAll(cities));
    return citiesList;
  }

  void updateForecasts(City city) async {
    final remoteForecasts = await _appRepository.getRemoteForecasts(city);
    remoteForecasts.fold(
      (error) => debugPrint(error.message),
      (forecasts) {
        emit(state.copyWith(forecasts: forecasts, message: StringContsants.forecastsUpdated));
        _appRepository.saveForecasts(forecasts);
      },
    );
  }

  void cityChanged(City city) {
    emit(state.copyWith(currentCity: city, previousCity: state.currentCity, message: null));
    _appRepository.saveCity(city);
  }

  void getDataOnLaunch() async {
    final savedCity = await _appRepository.getSavedCity();
    final savedForecasts = await _appRepository.getSavedForecasts();
    String? savedCityError;
    String? savedForecastsError;

    savedCity.fold(
      (error) {
        savedCityError = StringContsants.savedCityError;
        debugPrint(error.message);
        emit(state.copyWith(message: savedCityError));
      },
      (city) => emit(state.copyWith(currentCity: city, message: null)),
    );

    savedForecasts.fold(
      (error) {
        savedForecastsError = StringContsants.savedForecastsError;
        debugPrint(error.message);
      },
      (forecasts) {
        if (forecasts.first.date.day == DateTime.now().day) {
          emit(state.copyWith(forecasts: forecasts, message: null));
        }
      },
    );

    Future.delayed(const Duration(seconds: 2));

    if (savedCityError == null) {
      final newForecasts = await _appRepository.getRemoteForecasts(state.currentCity!);
      newForecasts.fold(
        (error) {
          if (savedForecastsError != null) {
            debugPrint(error.message);
            emit(state.copyWith(
              message:
                  '${StringContsants.savedForecastsError} ${StringContsants.remoteForecastsError}',
            ));
          } else {
            debugPrint(error.message);
            emit(state.copyWith(message: StringContsants.remoteForecastsError));
          }
        },
        (newForcasts) => emit(state.copyWith(
          forecasts: newForcasts,
          message: StringContsants.forecastsUpdated,
        )),
      );
    } else {
      debugPrint(StringContsants.savedCityError);
      emit(state.copyWith(message: StringContsants.savedCityError));
    }
  }
}
