import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/core/constants/strings.dart';
import 'package:weather_test/core/utils/snackbar.dart';
import 'package:weather_test/presentation/cubit/app_cubit.dart';
import 'package:weather_test/presentation/ui/widgets/city_search_widget.dart';
import 'package:weather_test/presentation/ui/widgets/current_forecast.dart';
import 'package:weather_test/presentation/ui/widgets/daily_forecast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<AppCubit>().getDataOnLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        debugPrint(state.toString());
        if (state.currentCity != null && state.currentCity != state.previousCity) {
          context.read<AppCubit>().updateForecasts(state.currentCity!);
        }
        if (state.message != null) {
          showSnackbar(context, state.message!);
        }
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.amberAccent,
          appBar: AppBar(
            title: Text(widget.title),
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
            child: const _CitySearch(),
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
          child: const _CitySearch(),
        ),
      ],
    );
  }
}

class _CitySearch extends StatelessWidget {
  const _CitySearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CitySearchField(
      initVal: context.read<AppCubit>().state.currentCity == null
          ? StringContsants.defaultCity
          : context.read<AppCubit>().state.currentCity!.name,
      pickCity: context.read<AppCubit>().cityChanged,
      suggestionsCallback: context.read<AppCubit>().getCities,
    );
  }
}
