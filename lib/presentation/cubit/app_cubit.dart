import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/data/repository/app_repository.dart';
import 'package:weather_test/domain/entity/city.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._appRepository) : super(const AppState());

  final AppRepository _appRepository;

  Future<List<City>> getCities(String query) async {
    return _appRepository.getCities(query);
  }

  void cityChanged(City city) => emit(state.copyWith(currentCity: city));
}
