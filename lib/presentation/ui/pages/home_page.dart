import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/core/injection/service_locator.dart';
import 'package:weather_test/presentation/cubit/app_cubit.dart';
import 'package:weather_test/presentation/ui/widgets/city_search_widget.dart';
import 'package:weather_test/presentation/ui/widgets/current_forecast.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AppCubit>(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          debugPrint(state.toString());
          if (state.currentCity != null) {
            debugPrint('need to update forecasts');

            context.read<AppCubit>().updateForecasts(state.currentCity!);
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.amberAccent,
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_city),
                        const SizedBox(
                          width: 12,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: CitySearchField(
                            initVal: 'Минск',
                            pickCity: context.read<AppCubit>().cityChanged,
                            suggestionsCallback: context.read<AppCubit>().getCities,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.forecasts.isNotEmpty)
                    Column(
                      children: [
                        CurrentForecast(forecast: state.forecasts.first),
                        ...state.forecasts
                            .skip(1)
                            .map((forecast) => Column(
                                  children: [
                                    Text(forecast.date.toString()),
                                    Text(forecast.temperature.toString()),
                                    Text(forecast.feelsLike.toString()),
                                    Text(forecast.humidity.toString()),
                                    Text(forecast.windSpeed.toString()),
                                  ],
                                ))
                            .toList(),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
