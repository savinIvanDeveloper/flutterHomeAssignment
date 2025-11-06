import 'dart:convert';
import 'package:home_assignment/core/utils/logger_helper.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkService {
  static final instance = NetworkService();

  final _connectivity = Connectivity();

  Future<bool> get hasConnection async {
    final result = await _connectivity.checkConnectivity();
    return result.first != ConnectivityResult.none;
  }

  Future<Map<String, dynamic>?> get(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheKey = 'cache_$url';
    final connected = await hasConnection;

    if (connected) {
      try {
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          prefs.setString(cacheKey, jsonEncode({'data': data}));

          return data;
        } else {
          logger.e('Request error: ${response.statusCode}');
          final cached = prefs.getString(cacheKey);
          if (cached != null) {
            return json.decode(cached)['data'];
          }
        }
      } catch (e) {
        logger.e('Request error: ${e.toString()}');
        final cached = prefs.getString(cacheKey);
        if (cached != null) {
          return json.decode(cached)['data'];
        }
      }
    } else {
      logger.e('No internet connection. Checkin cacksh for request $url');
      final cached = prefs.getString(cacheKey);
      if (cached != null) {
        return json.decode(cached)['data'];
      }
    }
    return null;
  }
}
