// ignore_for_file: avoid_dynamic_calls, must_be_immutable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:open_sky_weather/business_logic/core/quotes.dart';

import 'package:open_sky_weather/business_logic/model/model.dart';
import 'package:open_sky_weather/business_logic/utilities/app_theme.dart';

class SunScheduleCardComponent extends StatelessWidget {
  final Color color;
  late Model model;

  final TextStyle caption2RegularTextStyle;

  final Function convertTimeStampToHumanHour;

  final bool isItDayNow;

  SunScheduleCardComponent({
    super.key,
    required this.color,
    required this.model,
    required this.caption2RegularTextStyle,
    required this.convertTimeStampToHumanHour,
    required this.isItDayNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Image.asset(
                    "assets/icons/sunrise.png",
                    width: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      (model.getCurrent() != null)
                          ? "${convertTimeStampToHumanHour(model.getCurrent()!.getSunrise())}"
                          : "-",
                      style: body1RegularTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "Sunrise",
                    style: caption2RegularTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Image.asset(
                isItDayNow ? "assets/icons/sun.png" : "assets/icons/moon.png",
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/icons/sunset.png",
                    width: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      (model.getCurrent() != null)
                          ? "${convertTimeStampToHumanHour(model.getCurrent()!.getSunset())}"
                          : "-",
                      style: body1RegularTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "Sunset",
                    style: caption2RegularTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              isItDayNow
                  ? dayQuotes[
                      Random().nextInt(dayQuotes.length)] //"A Shiny New Day!"
                  : nightQuotes[Random().nextInt(nightQuotes.length)],
              style: captionRegularTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
