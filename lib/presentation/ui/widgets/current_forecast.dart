import 'package:flutter/material.dart';
import 'package:weather_test/core/constants/strings.dart';
import 'package:weather_test/domain/entity/forecast.dart';

class CurrentForecast extends StatelessWidget {
  const CurrentForecast({
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
          style: textTheme.headline1,
        ),
        Text(
          '${forecast.temperature.ceil()} ${StringContsants.celciumSign}',
          style: textTheme.subtitle1?.copyWith(fontSize: 32),
        ),
        _AdditionalInfo(
          title: StringContsants.feelsLikeText,
          value: forecast.feelsLike.ceil().toString(),
          units: StringContsants.celciumSign,
        ),
        _AdditionalInfo(
          title: StringContsants.pressureText,
          value: forecast.pressure.toString(),
          units: StringContsants.pressureUnit,
        ),
        _AdditionalInfo(
          title: StringContsants.humidityText,
          value: forecast.humidity.toString(),
          units: StringContsants.humidityUnit,
        ),
        _AdditionalInfo(
          title: StringContsants.windSpeedText,
          value: forecast.windSpeed.toString(),
          units: StringContsants.windSpeedUnit,
        ),
      ],
    );
  }
}

class _AdditionalInfo extends StatelessWidget {
  const _AdditionalInfo({
    required this.title,
    required this.value,
    this.units,
    Key? key,
  }) : super(key: key);

  final String title;
  final String value;
  final String? units;

  @override
  Widget build(BuildContext context) {
    final textstyle = Theme.of(context).textTheme.subtitle2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: textstyle),
        const SizedBox(width: 8),
        Text(value, style: textstyle),
        if (units != null) ...[
          Text(' ', style: textstyle),
          Text(units!, style: textstyle),
        ]
      ],
    );
  }
}
