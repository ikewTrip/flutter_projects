import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:telestat_test/src/data/weather_repository.dart';
import 'package:telestat_test/src/models/weather/weather.dart';
import 'package:telestat_test/src/services/location_service.dart';

final currentWeatherProvider = FutureProvider.autoDispose<Weather>((ref) async {
  final position =
      await ref.watch(locationServiceProvider).getCurrentLocation();
  final weather = await ref
      .watch(weatherRepositoryProvider)
      .getWeather(lat: position!.latitude, lon: position.longitude);
  return weather;
});
