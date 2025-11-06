import 'package:home_assignment/core/models/weather.dart';
import 'package:home_assignment/features/weather/data/weather_service.dart';

class WeatherRepo {
  final WeatherService _service;

  WeatherRepo({ required WeatherService service }) : _service = service;

  Future<Weather> getWeatherFor(double lat, double long) async {
    final result = await _service.getWeather(lat, long);
    return Weather.fromJson(result);
  }
}
