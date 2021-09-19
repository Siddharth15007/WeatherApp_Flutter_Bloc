// ignore: import_of_legacy_library_into_null_safe, unused_import
import 'package:bloc/bloc.dart';
import 'package:bloc_weather_app/bloc/weather_bloc.dart';
import 'package:bloc_weather_app/repositories/weather_rep.dart';
import 'package:bloc_weather_app/screens/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
          create: (context) => WeatherBloc(WeatherRepo()),
          child: const WeatherScreen()),
    );
  }
}
