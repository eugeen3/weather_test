import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/data/repository/app_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(this._appRepository) : super(AppInitial());

  final AppRepository _appRepository;

  getCities() {
    _appRepository.getCities();
  }
}
