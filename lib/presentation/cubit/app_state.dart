part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.currentCity,
    this.isLoading = true,
    this.error,
    this.cityQuery,
  });

  final City? currentCity;
  final bool isLoading;
  final String? error;
  final String? cityQuery;

  AppState copyWith({
    City? currentCity,
    bool? isLoading,
    String? error,
    String? cityQuery,
  }) {
    return AppState(
      currentCity: currentCity ?? this.currentCity,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      cityQuery: cityQuery ?? this.cityQuery,
    );
  }

  @override
  List<Object?> get props => [currentCity, isLoading, error];

  @override
  bool get stringify => true;
}
