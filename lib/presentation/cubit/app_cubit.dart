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

  void cityChanged(City city) => emit(state.copyWith(currentCity: city));

  void getData() async {
    emit(state.copyWith(isLoading: true));
    final savedCity = await _appRepository.getSavedCity();
    final savedForecasts = await _appRepository.getSavedForecasts();
    String? savedForecastsError;
    bool savedForecastsShown = false;

    savedCity.fold(
      (error) {
        debugPrint(error.message);
        emit(state.copyWith(error: StringContsants.savedCityError));
      },
      (city) => emit(state.copyWith(currentCity: city)),
    );

    savedForecasts.fold(
      (error) {
        savedForecastsError = StringContsants.savedForecastsError;
        debugPrint(error.message);
      },
      (forecasts) {
        if (forecasts.first.date == DateTime.now()) {
          emit(state.copyWith(forecasts: forecasts));
          savedForecastsShown = true;
        }
      },
    );

    if (savedForecastsError == null && savedForecastsShown) {
      emit(state.copyWith(isLoading: false));
    }

    final newForecasts = await _appRepository.getRemoteForecasts();
    newForecasts.fold(
      (error) {
        if (savedForecastsError != null) {
          debugPrint(error.message);
          emit(state.copyWith(
            error:
                '${StringContsants.savedForecastsError} ${StringContsants.remoteForecastsError}',
          ));
        } else {
          debugPrint(error.message);
          emit(state.copyWith(error: StringContsants.remoteForecastsError));
        }
      },
      (newForcasts) => emit(state.copyWith(forecasts: newForcasts)),
    );
  }
}
