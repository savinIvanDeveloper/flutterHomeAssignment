import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:home_assignment/features/weather/provider/weather_provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherScreen> {
  IconData _mapWeatherToIcon(String main) {
    switch (main.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
      case 'drizzle':
        return Icons.grain; // you can pick a better icon
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'fog':
        return Icons.blur_on;
      default:
        return Icons.wb_cloudy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather')),
      body: _contentView,
    );
  }

  Widget get _contentView {
    final provider = context.read<WeatherProvider>();
    final weather = provider.weather;
    if (weather != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _mapWeatherToIcon(weather.main),
              size: 120,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 24),
            Text(weather.description, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              '${weather.temp.toStringAsFixed(1)} °C',
              style: const TextStyle(fontSize: 28),
            ),
          ],
        ),
      );
    } else {
      return Center(child: Text(provider.error ?? 'Something went wrong'));
    }
  }
}
