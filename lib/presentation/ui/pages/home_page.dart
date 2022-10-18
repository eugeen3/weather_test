import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/core/injection/service_locator.dart';
import 'package:weather_test/core/utils/snackbar.dart';
import 'package:weather_test/presentation/cubit/app_cubit.dart';
import 'package:weather_test/presentation/ui/widgets/city_search_widget.dart';
import 'package:weather_test/presentation/ui/widgets/current_forecast.dart';
import 'package:weather_test/presentation/ui/widgets/daily_forecast.dart';

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
          if (state.error != null) {
            showSnackbar(context, state.error!);
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.amberAccent,
            appBar: AppBar(
              title: Text(title),
            ),
            body: OrientationBuilder(
              builder: (context, orientation) => orientation == Orientation.portrait
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const _SearchFieldPortrait(),
                        if (state.forecasts.isNotEmpty)
                          Column(
                            children: [
                              CurrentForecast(forecast: state.forecasts.first),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: state.forecasts
                                    .skip(1)
                                    .map((forecast) => DailyForecast(forecast: forecast))
                                    .toList(),
                              ),
                            ],
                          ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              const _SearchFieldLandscape(),
                              if (state.forecasts.isNotEmpty) ...[
                                const Spacer(),
                                CurrentForecast(forecast: state.forecasts.first),
                              ]
                            ],
                          ),
                          if (state.forecasts.isNotEmpty)
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: state.forecasts
                                    .skip(1)
                                    .map((forecast) => DailyForecast(forecast: forecast))
                                    .toList(),
                              ),
                            )
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _SearchFieldPortrait extends StatelessWidget {
  const _SearchFieldPortrait({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class _SearchFieldLandscape extends StatelessWidget {
  const _SearchFieldLandscape({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.location_city),
        const SizedBox(
          width: 12,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: CitySearchField(
            initVal: 'Минск',
            pickCity: context.read<AppCubit>().cityChanged,
            suggestionsCallback: context.read<AppCubit>().getCities,
          ),
        ),
      ],
    );
  }
}
