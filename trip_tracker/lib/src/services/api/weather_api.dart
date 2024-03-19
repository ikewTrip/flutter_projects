import 'package:telestat_test/src/services/api/api_keys.dart';

class WetherAPI {
  final String apiKey = APIKeys.openWeatherAPIKey;

  static const String _apiBaseUrl = "api.openweathermap.org";
  static const String _apiPath = "/data/2.5";

  Uri weather(double lat, double lon) => Uri.https(
        _apiBaseUrl,
        '$_apiPath/weather',
        {
          'lat': lat.toString(),
          "lon": lon.toString(),
          "appid": apiKey,
        },
      );
}
