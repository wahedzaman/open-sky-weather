// ignore_for_file: must_be_immutable, avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:open_sky_weather/business_logic/model/model.dart';
import 'package:open_sky_weather/business_logic/utilities/app_theme.dart';

class HourlyWeatherForecastComponent extends StatelessWidget {
  final Color color;
  late Model model;

  final Function convertTimeStampToHumanHour;

  HourlyWeatherForecastComponent({
    super.key,
    required this.color,
    required this.model,
    required this.convertTimeStampToHumanHour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: model.hourly!.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${convertTimeStampToHumanHour(model.hourly![index].dt!)}",
                  style: captionRegularTextStyle,
                ),
                Image.asset(
                  "assets/icons/${model.hourly![index].weather![0].icon}.png",
                  width: 50,
                  height: 50,
                ),
                Text(
                  "${model.hourly![index].temp!.ceil()}°C",
                  style: body1BoldTextStyle,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
