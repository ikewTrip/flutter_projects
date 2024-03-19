import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telestat_test/src/models/weather/weather.dart';
import 'package:telestat_test/src/services/api/api_exception.dart';
import 'package:telestat_test/src/services/providers/city_provider.dart';
import 'package:telestat_test/src/services/providers/weather_provider.dart';
import 'package:telestat_test/src/widgets/weather/weather_icon_image.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(currentWeatherProvider);
    final city = ref.watch(cityProvider);

    var progressIndicatorWidget = const Padding(
      padding: EdgeInsets.symmetric(vertical: 53),
      child: CircularProgressIndicator(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        city.isRefreshing
            ? const Text("Refreshing...")
            : city.when(
                data: (weather) => Text(
                  city.value.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                loading: () => const Text(''),
                error: (error, stackTrace) => const Text(''),
              ),
        weather.isRefreshing
            ? progressIndicatorWidget
            : weather.when(
                data: (weatherData) =>
                    CurrentWeatherContents(data: weatherData),
                loading: () => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 53),
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) {
                  if (error is APIException) {
                    return Text(error.message);
                  }
                  return const Text('Something went wrong!');
                },
              ),
      ],
    );
  }
}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({super.key, required this.data});
  final Weather data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temp.celsius.toInt().toString();
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final highAndLow = 'H:$maxTemp° L:$minTemp°';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WeatherIconImage(
              iconUrl: data.iconUrl,
              size: 75,
            ),
            Text(temp, style: textTheme.displaySmall),
          ],
        ),
        Text(data.description[0].toUpperCase() + data.description.substring(1),
            style: textTheme.titleLarge),
        Text(highAndLow, style: textTheme.titleMedium),
      ],
    );
  }
}
