import 'package:flutter/material.dart';
import 'package:home_assignment/core/models/weather.dart';
import 'package:home_assignment/core/utils/logger_helper.dart';
import 'package:home_assignment/features/weather/data/weather_repo.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepo _repo;
  Weather? _weather;
  bool _isLoading = false;
  String? _error;
  final double _lat = 31.9045;
  final double _long = 34.81;

  WeatherProvider({ required WeatherRepo repo }) : _repo = repo;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchWeather() async {
    _isLoading = true;
    _error = null;

    notifyListeners();

    try {
      _weather = await _repo.getWeatherFor(_lat, _long);
    } catch (e) {
      logger.e(e.toString());
      _error = 'Something went wrong';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
