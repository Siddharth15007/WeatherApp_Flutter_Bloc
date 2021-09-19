import 'package:bloc_weather_app/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityInputField extends StatelessWidget {
  const CityInputField({Key? key, required this.hintText}) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) => submitCityName(context, value),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final weatherBloc = context.read<WeatherBloc>();

    weatherBloc.add(GetWeather(cityName));
  }
}
