class Api {
  static String baseUrl = 'https://www.weizmann.ac.il/api/v1';
  static String photosBaseUrl = '$baseUrl/people';
  static String contactBaseUrl = '$baseUrl/people.json';
  static String weatherBaseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static String local = 'http://localhost:8000';
  static String localBaseUrl = '$local/api';
  static String localContactBaseUrl = '$localBaseUrl/contacts';
  static String localPhotosBaseUrl = '$localBaseUrl/photos';
  static String localWeatherBaseUrl = '$localBaseUrl/weather';

  static final bool _useLocal = false;

  static String getPhotoUrl(String path) {
    return _useLocal ? '$local$path' : '$photosBaseUrl$path';
  }

  static String getContactUrl(String name) { 
    return _useLocal ? '$localContactBaseUrl?name=$name' : '$contactBaseUrl?name=$name';
  }

  static String getWeatherUrl(double lat, double long, String appId) {
    return _useLocal ? '$localWeatherBaseUrl?lat=$lat&lon=$long' : '$weatherBaseUrl?lat=$lat&lon=$long&appid=$appId&units=metric';
  }
}
