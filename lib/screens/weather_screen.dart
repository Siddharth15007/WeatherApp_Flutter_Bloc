import 'package:bloc_weather_app/bloc/weather_bloc.dart';
import 'package:bloc_weather_app/models/weather_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'widgets/city_input_field.dart';
import 'widgets/weather_details.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is WeatherInitial) {
            return buildInitialInput();
          } else if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is WeatherLoaded) {
            return buildColumnWithData(state.weather);
          } else {
            // (state is WeatherError)
            return buildInitialInput();
          }
        },
      ),
    );
  }

  Widget buildInitialInput() {
    return Stack(
      children: [
        Image.network(
          "https://source.unsplash.com/412x732/?nature,weather",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.black38),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Weather Check",
                textScaleFactor: 2.5,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: CityInputField(
                  hintText: "Enter City Name...",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Stack buildColumnWithData(WeatherModel weather) {
    var now = DateTime.now();
    return Stack(
      children: [
        Image.network(
          "https://source.unsplash.com/412x732/?nature,weather",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.black38),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    weather.name!,
                    style: GoogleFonts.lato(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    // "07:50 PM - Monday, 9 Nov 2021",
                    DateFormat("kk:mm, dd MMM yyyy").format(now),
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const CityInputField(
                hintText: "Search again...",
              ),
              const SizedBox(
                height: 80,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${(weather.main!.temp - 273.15).round()}\u2103",
                    // "24\u2103",
                    style: GoogleFonts.lato(
                      fontSize: 75,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    children: [
                      Image.network(
                        "https://openweathermap.org/img/wn/${weather.weather![0].icon}.png",
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        weather.weather![0].main,
                        style: GoogleFonts.lato(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white30),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WeatherDetails(
                    detailTitle: "Wind",
                    detailUnit: "Km/h",
                    chartLevel: 20,
                    countTxt: weather.wind!.speed!,
                  ),
                  WeatherDetails(
                    detailTitle: "Pressure",
                    detailUnit: "hPa",
                    chartLevel: 17,
                    countTxt: weather.main!.pressure!.toDouble(),
                  ),
                  WeatherDetails(
                    detailTitle: "Humidity",
                    detailUnit: "%",
                    chartLevel: 36,
                    countTxt: weather.main!.humidity!.toDouble(),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
