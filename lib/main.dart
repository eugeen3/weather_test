import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/core/injection/service_locator.dart';
import 'package:weather_test/presentation/cubit/app_cubit.dart';
import 'package:weather_test/presentation/ui/widgets/city_search_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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
          if (state.currentCity != state.previousCity &&
              state.currentCity != null) {
            debugPrint('need to update forecasts');

            context.read<AppCubit>().updateForecasts(state.currentCity!);
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CitySearchField(
                      initVal: 'Минск',
                      pickCity: context.read<AppCubit>().cityChanged,
                      suggestionsCallback: context.read<AppCubit>().getCities,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        ...state.forecasts
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
                      ]),
                    ),
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
