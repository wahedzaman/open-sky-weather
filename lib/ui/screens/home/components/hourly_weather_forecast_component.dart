// ignore_for_file: must_be_immutable, avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:open_sky_weather/business_logic/model/model.dart';
import 'package:open_sky_weather/ui/screens/home/components/hourly_weather_forecast_list_item.dart';

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
          return HourlyWeatherForecastListItem(
            color: color,
            index: index,
            model: model,
          );
        },
      ),
    );
  }
}
