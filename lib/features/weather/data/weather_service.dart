import 'package:home_assignment/core/services/network_service.dart';
import 'package:home_assignment/core/utils/api_constants.dart';

class WeatherService {
  final String _appId = '977d70d0416361b041c496365444ef00';

  Future<Map<String, dynamic>> getWeather(double lat, double long) async {
    final url = Api.getWeatherUrl(lat, long, _appId);
    final data = await NetworkService.instance.get(url);
    if (data != null) {
      return data;
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
