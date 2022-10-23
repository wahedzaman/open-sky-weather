// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:open_sky_weather/business_logic/model/model.dart';
import 'package:open_sky_weather/business_logic/utilities/app_theme.dart';
import 'package:open_sky_weather/business_logic/utilities/time_utility.dart';

// ignore: must_be_immutable
class HourlyWeatherForecastListItem extends StatelessWidget {
  final Color color;
  late Model model;
  final int index;

  HourlyWeatherForecastListItem({
    super.key,
    required this.color,
    required this.model,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
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
            convertTimeStampToHumanHour(model.hourly![index].dt),
            style: captionRegularTextStyle,
          ),
          Image.asset(
            "assets/icons/${model.hourly![index].weather![0].icon}.png",
            width: 50,
            height: 50,
          ),
          Text(
            "${model.hourly![index].temp!.ceil()}°C",
            style: body1BoldTextStyle.copyWith(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
