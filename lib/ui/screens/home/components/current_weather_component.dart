// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:jiffy/jiffy.dart';

import 'package:open_sky_weather/business_logic/model/model.dart';
import 'package:open_sky_weather/business_logic/utilities/app_theme.dart';

class CurrentWeatherComponent extends StatelessWidget {
  late Model model;

  CurrentWeatherComponent(this.model);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Center(
            child: Image.asset(
              (model.getCurrent() != null &&
                      model.getCurrent()!.getWeather() != null)
                  ? "assets/icons/${model.getCurrent()!.getWeather()![0].icon}.png"
                  : "",
              width: 100,
              height: 100,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                // ignore: avoid_dynamic_calls
                "${(model.getCurrent() != null) ? model.getCurrent()!.getWeather()![0].description!.toUpperCase() : ""}",
                textAlign: TextAlign.center,
                style: h8BoldTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (model.getCurrent() != null)
                      ? "${model.getCurrent()!.getTemp().ceil()}°C"
                      : "",
                  style: temperatureBoldLarge,
                ),
              ),
              Text(
                (model.getCurrent() != null)
                    ? Jiffy().format("MMMM d,EEEE")
                    : "",
                style: h9RegularTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
