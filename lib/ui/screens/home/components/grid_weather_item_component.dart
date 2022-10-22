import 'package:flutter/material.dart';
import 'package:open_sky_weather/business_logic/utilities/app_theme.dart';

class GridWeatherItemComponent extends StatelessWidget {
  final IconData iconData;

  final dynamic number;

  final dynamic label;

  const GridWeatherItemComponent(
    this.number,
    this.label,
    this.iconData,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.white,
            size: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$number",
              style: body1RegularTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            "$label",
            style: caption2RegularTextStyle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
