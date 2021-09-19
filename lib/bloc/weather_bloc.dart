import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_weather_app/models/weather_model.dart';
import 'package:bloc_weather_app/repositories/weather_rep.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo _weatherRepo;

  WeatherBloc(this._weatherRepo) : super(const WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      try {
        yield const WeatherLoading();

        final weather = await _weatherRepo.getWeather(event.cityName);

        yield WeatherLoaded(weather);
      } on NetworkException {
        yield const WeatherError(
            "Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
