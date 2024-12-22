import 'package:flutter/material.dart';
import 'weather_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hava Durumu Uygulaması',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _controller = TextEditingController();
  String _cityName = '';
  String _weatherInfo = '';

  Future<void> _getWeather() async {
    WeatherService weatherService = WeatherService();
    try {
      final weatherData = await weatherService.fetchWeather(_cityName);
      setState(() {
        _weatherInfo = 'Sıcaklık: ${weatherData['main']['temp']}°C\n'
            'Hava Durumu: ${weatherData['weather'][0]['description']}';
      });
    } catch (e) {
      setState(() {
        _weatherInfo = 'Hata: Şehir bulunamadı';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hava Durumu Uygulaması'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Şehir Adı',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _cityName = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getWeather,
              child: Text('Hava Durumunu Al'),
            ),
            SizedBox(height: 20),
            Text(
              _weatherInfo,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
