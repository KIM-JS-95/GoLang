import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherWidget extends StatefulWidget {
  final String city;
  const WeatherWidget({Key? key, required this.city}) : super(key: key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {

  late bool _isLoading = true;
  late Map<String, dynamic> _weatherInfo;
  late Map<String, dynamic> _main;
  late Map<String, dynamic> _wind;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? _buildLoadingScreen()
        : Container(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Weather: ${_weatherInfo['description']}",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(width: 10.0),
                  if (_weatherInfo['icon'].isNotEmpty)
                    Image.network(
                      "https://openweathermap.org/img/w/${_weatherInfo['icon']}.png",
                      width: 50.0,
                      height: 50.0,
                    ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                "Temperature:${_main['temp']}°C",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "Humidity: ${_main['humidity']}%",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "Wind Speed: ${_wind['speed']} m/s",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _fetchWeather() async {
    final apiKey = 'ab85aeb8e0825e98eba2066185a578d5'; // OpenWeatherMap API Key
    final city = CodeToName(widget.city);
    print(city);
    final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=$apiKey&units=metric');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> weather = data['weather'];
        setState(() {
          _main = data['main'];
          _wind = data['wind'];
          _weatherInfo = weather[0];
        });
      } else {
        print('Failed to load weather: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        _isLoading = false; // Set loading to false after API call
      });
    }
  }

  String CodeToName(String code) {
    if (code == "OIT")
      return "OITA";
    else
      return "KOREA";
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
