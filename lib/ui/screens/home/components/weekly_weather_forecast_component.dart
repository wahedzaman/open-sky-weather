// ignore_for_file: avoid_dynamic_calls, must_be_immutable

import 'package:flutter/material.dart';
import 'package:open_sky_weather/business_logic/model/model.dart';
import 'package:open_sky_weather/business_logic/utilities/app_theme.dart';

class WeeklyWeatherForecastComponent extends StatelessWidget {
  final Color color;
  late Model model;

  final Function convertTimeStampToHumanDay;
  final Function convertTimeStampToHumanDateMonth;

  WeeklyWeatherForecastComponent({
    super.key,
    required this.color,
    required this.model,
    required this.convertTimeStampToHumanDay,
    required this.convertTimeStampToHumanDateMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: model.daily!.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${convertTimeStampToHumanDay(model.daily![index].dt!)}",
                  style: body1BoldTextStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  "${convertTimeStampToHumanDateMonth(model.daily![index].dt!)}",
                  style: body2RegularTextStyle,
                ),
                const SizedBox(height: 20),
                Text(
                  "${model.daily![index].weather![0].main}",
                  style: body1MediumTextStyle,
                ),
                const SizedBox(height: 20),
                Image.asset(
                  "assets/icons/${model.daily![index].weather![0].icon}.png",
                  width: 60,
                  height: 60,
                ),
                const SizedBox(height: 20),
                Text(
                  "${model.daily![index].temp!.min!.ceil()}°C",
                  style: body1BoldTextStyle.copyWith(color: Colors.blue),
                ),
                const SizedBox(height: 20),
                Text(
                  "${model.daily![index].temp!.max!.ceil()}°C",
                  style: body1BoldTextStyle.copyWith(color: Colors.red),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
