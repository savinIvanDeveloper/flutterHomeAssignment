class Weather {
  final String main; // "Clear", "Clouds", etc
  final String description; // "clear sky"
  final String cityName; // "Rehovot"
  final double temp; // in Celsius

  Weather({
    required this.main,
    required this.description,
    required this.cityName,
    required this.temp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weatherData = json['weather'][0];
    final mainData = json['main'];
    return Weather(
      main: weatherData['main'],
      description: weatherData['description'],
      cityName: json['name'],
      temp: (mainData['temp'] as num).toDouble(),
    );
  }
}
