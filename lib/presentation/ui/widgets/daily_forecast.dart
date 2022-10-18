import 'package:flutter/material.dart';
import 'package:weather_test/core/constants/strings.dart';
import 'package:weather_test/domain/entity/forecast.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({
    required this.forecast,
    Key? key,
  }) : super(key: key);

  final Forecast forecast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          '${forecast.date.day}.${forecast.date.month}',
          style: textTheme.headline1?.copyWith(fontSize: 16),
        ),
        Text(
          '${forecast.temperature} ${StringContsants.celciumSign}',
          style: textTheme.subtitle1?.copyWith(fontSize: 18),
        ),
      ],
    );
  }
}
