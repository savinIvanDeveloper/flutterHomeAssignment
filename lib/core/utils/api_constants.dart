class Api {
  static String baseUrl = 'https://www.weizmann.ac.il/api/v1';
  static String photosBaseUrl = '$baseUrl/people';
  static String contactBaseUrl = '$baseUrl/people.json';
  static String weatherBaseUrl = 'https://api.openweathermap.org/data/2.5/weather';


  static String getPhotoUrl(String path) {
    return '$photosBaseUrl$path';
  }

  static String getContactUrl(String name) {
    return '$contactBaseUrl?name=$name';
  }

  static String getWeatherUrl(double lat, double long, String appId) {
    return '$weatherBaseUrl?lat=$lat&lon=$long&appid=$appId&units=metric';
  }
}
