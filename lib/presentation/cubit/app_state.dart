part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.currentCity,
    this.isLoading = true,
    this.error,
    this.cityQuery,
    this.forecasts = const [],
  });

  final City? currentCity;
  final bool isLoading;
  final String? error;
  final String? cityQuery;
  final List<Forecast> forecasts;

  AppState copyWith({
    City? currentCity,
    bool? isLoading,
    String? error,
    String? cityQuery,
    List<Forecast>? forecasts,
  }) {
    return AppState(
      currentCity: currentCity ?? this.currentCity,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      cityQuery: cityQuery ?? this.cityQuery,
      forecasts: forecasts ?? this.forecasts,
    );
  }

  @override
  List<Object?> get props =>
      [currentCity, isLoading, error, cityQuery, forecasts];

  @override
  bool get stringify => true;
}
