import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:telestat_test/src/models/weather/weather.dart';
import 'package:telestat_test/src/services/api/api_exception.dart';
import 'package:telestat_test/src/services/api/weather_api.dart';

class HttpWeatherRepository {
  HttpWeatherRepository({required this.api});
  final WetherAPI api;

  Future<Weather> getWeather({required double lat, required double lon}) =>
      _getData(
        uri: api.weather(lat, lon),
        builder: (data) => Weather.fromJson(data),
      );

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(Map<String, dynamic> data) builder,
  }) async {
    try {
      final response = await http.get(uri);
      switch (response.statusCode) {
        case 200:
          final Map<String, dynamic> jsonDataMap = json.decode(response.body);
          return builder(jsonDataMap);
        case 401:
          throw InvalidApiKeyException();
        case 400:
          throw InvalidLocation();
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}

final weatherRepositoryProvider = Provider<HttpWeatherRepository>((ref) {
  return HttpWeatherRepository(
    api: WetherAPI(),
  );
});
