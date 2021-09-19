import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({
    Key? key,
    required this.countTxt,
    required this.detailTitle,
    required this.detailUnit,
    required this.chartLevel,
  }) : super(key: key);

  final double countTxt;
  final String detailTitle;
  final String detailUnit;
  final double chartLevel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          detailTitle,
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          countTxt.toString(),
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          detailUnit,
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Stack(
          children: [
            Container(
              height: 5,
              width: 50,
              color: Colors.white38,
            ),
            Container(
              height: 5,
              width: chartLevel,
              color: Colors.greenAccent,
            )
          ],
        )
      ],
    );
  }
}
