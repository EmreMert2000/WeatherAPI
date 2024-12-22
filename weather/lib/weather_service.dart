import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'API_KEY';
  final String baseUrl = 'BASE URL';

  Future<Map<String, dynamic>> fetchWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Hava durumu verisi alınamadı');
    }
  }
}
