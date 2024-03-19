import 'package:telestat_test/src/models/weather/temperature.dart';

class Weather {
  Weather({
    required this.temp,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.date,
    required this.icon,
  });

  final Temperature temp;
  final Temperature minTemp;
  final Temperature maxTemp;
  final String description;
  final DateTime date;
  final String icon;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final temp = Temperature.kelvin(json['main']['temp'].toDouble());
    final minTemp = Temperature.kelvin(json['main']['temp_min'].toDouble());
    final maxTemp = Temperature.kelvin(json['main']['temp_max'].toDouble());
    final description = json['weather'][0]['description'] as String;
    final date = DateTime.fromMillisecondsSinceEpoch(
      json['dt'] * 1000,
      isUtc: true,
    );
    final icon = json['weather'][0]['icon'] as String;

    return Weather(
      temp: temp,
      minTemp: minTemp,
      maxTemp: maxTemp,
      description: description,
      date: date,
      icon: icon,
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
}