part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.currentCity,
    this.previousCity,
    this.message,
    this.forecasts = const [],
  });

  final City? currentCity;
  final City? previousCity;
  final String? message;
  final List<Forecast> forecasts;

  AppState copyWith({
    City? currentCity,
    City? previousCity,
    String? message,
    List<Forecast>? forecasts,
  }) {
    return AppState(
      currentCity: currentCity ?? this.currentCity,
      previousCity: previousCity ?? this.previousCity,
      message: message ?? message,
      forecasts: forecasts ?? this.forecasts,
    );
  }

  @override
  List<Object?> get props => [currentCity, previousCity, message, forecasts];

  @override
  bool get stringify => true;
}
