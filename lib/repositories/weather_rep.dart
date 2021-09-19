import 'dart:convert';

import 'package:bloc_weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherRepo {
  Future<WeatherModel> getWeather(String cityName) async {
    final result = await http.Client().get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=43ea6baaad7663dc17637e22ee6f78f2"));

    if (result.statusCode != 200) throw Exception();

    return parsedJson(result.body);
  }

  WeatherModel parsedJson(final response) {
    final jsonDecoded = json.decode(response);

    //final jsonWeather = jsonDecoded();

    return WeatherModel.fromJson(jsonDecoded);
  }
}

class NetworkException implements Exception {}
