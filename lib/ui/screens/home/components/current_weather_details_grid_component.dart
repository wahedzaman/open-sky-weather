// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_sky_weather/business_logic/model/model.dart';
import 'package:open_sky_weather/ui/screens/home/components/grid_weather_item_component.dart';

class CurrentWeatherDetailsGridComponent extends StatelessWidget {
  late Model model;
  final Color color;
  final TextStyle body1RegularTextStyle;
  final TextStyle caption2RegularTextStyle;

  CurrentWeatherDetailsGridComponent({
    super.key,
    required this.model,
    required this.color,
    required this.body1RegularTextStyle,
    required this.caption2RegularTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView.count(
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            shrinkWrap: true,
            children: <Widget>[
              GridWeatherItemComponent(
                (model.getCurrent() != null)
                    ? "${model.getCurrent()!.getFeelsLike().ceil()}°C"
                    : "-",
                "Feels Like",
                CupertinoIcons.thermometer,
              ),
              GridWeatherItemComponent(
                (model.getCurrent() != null)
                    ? model.getCurrent()!.getPressure()
                    : "-",
                "Pressure",
                CupertinoIcons.gauge,
              ),
              GridWeatherItemComponent(
                (model.getCurrent() != null)
                    ? model.getCurrent()!.getUvi()
                    : "-",
                "UV",
                CupertinoIcons.sun_max,
              ),
              GridWeatherItemComponent(
                (model.getCurrent() != null)
                    ? "${model.getCurrent()!.getHumidity()}%"
                    : "-",
                "Humidity",
                CupertinoIcons.drop,
              ),
              GridWeatherItemComponent(
                (model.getCurrent() != null)
                    ? "${model.getCurrent()!.getWindSpeed()}"
                    : "-",
                "Wind (km/h)",
                Icons.air_sharp,
              ),
              GridWeatherItemComponent(
                (model.getCurrent() != null)
                    ? "${model.getCurrent()!.getVisibility() / 1000}km"
                    : "-",
                "Visibility",
                CupertinoIcons.eye,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
