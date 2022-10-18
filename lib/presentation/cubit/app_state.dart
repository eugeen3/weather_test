part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.currentCity,
    this.previousCity,
    this.isLoading = true,
    this.error,
    this.forecasts = const [],
  });

  final City? currentCity;
  final City? previousCity;
  final bool isLoading;
  final String? error;
  final List<Forecast> forecasts;

  AppState copyWith({
    City? currentCity,
    City? previousCity,
    bool? isLoading,
    String? error,
    List<Forecast>? forecasts,
  }) {
    return AppState(
      currentCity: currentCity ?? this.currentCity,
      previousCity: previousCity ?? this.previousCity,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      forecasts: forecasts ?? this.forecasts,
    );
  }

  @override
  List<Object?> get props =>
      [currentCity, previousCity, isLoading, error, forecasts];

  @override
  bool get stringify => true;
}
