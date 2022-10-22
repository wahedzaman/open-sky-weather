import 'package:flutter/material.dart';
import 'package:open_sky_weather/ui/screens/home/home_screen.dart';

// ignore: must_be_immutable
class AppScreenTabContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: HomeScreen(),
    );
  }
}
