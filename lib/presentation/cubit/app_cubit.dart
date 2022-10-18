import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/data/repository/app_repository.dart';
import 'package:weather_test/domain/entity/city.dart';
import 'package:weather_test/domain/entity/forecast.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._appRepository) : super(const AppState());

  final AppRepository _appRepository;

  Future<List<City>> getCities(String query) async {
    return _appRepository.getCities(query);
  }

  void cityChanged(City city) => emit(state.copyWith(currentCity: city));

  void getData() async {
    final savedCity = await _appRepository.getSavedCity();
    final savedForecasts = await _appRepository.getSavedForecasts();
  }
}
