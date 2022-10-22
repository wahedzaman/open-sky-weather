// ignore_for_file: deprecated_member_use, unused_element, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_sky_weather/business_logic/controller/home_screen_controller.dart';
import 'package:open_sky_weather/business_logic/utilities/app_theme.dart';
import 'package:open_sky_weather/business_logic/utilities/utility.dart';
import 'package:open_sky_weather/ui/screens/home/components/current_weather_component.dart';
import 'package:open_sky_weather/ui/screens/home/components/current_weather_details_grid_component.dart';
import 'package:open_sky_weather/ui/screens/home/components/hourly_weather_forecast_component.dart';
import 'package:open_sky_weather/ui/screens/home/components/sun_schedule_card_component.dart';
import 'package:open_sky_weather/ui/screens/home/components/weekly_weather_forecast_component.dart';
import 'package:open_sky_weather/ui/screens/settings/settings_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///***
///  (screen -> interaction) -> action() -> state changes -> user feedback
///  screen      <->       business logic(modelview)    <-> service (api/db/file/network)
///
///
/// */

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final RefreshController _refreshController = RefreshController();

  // ignore: always_declare_return_types
  _init(context) {
    homeScreenController.init();
  }

  Future<void> _onRefresh() async {
    await homeScreenController.callAPI();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.black,
        brightness: Brightness.light,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GetBuilder<HomeScreenController>(
          init: homeScreenController,
          builder: (controller) {
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () => _onRefresh(),
              header: const WaterDropMaterialHeader(
                backgroundColor: Colors.white,
              ),
              child: Material(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: aColor.brandDark.color,
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Get.to(SettingsScreen()),
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Currently",
                          // "${Get.find<Utility>().userLocationAddress.value}",
                          style: h6RegularextStyle,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "at ${Get.find<Utility>().userLocationAddress.value}",
                          style: h8RegularTextStyle.copyWith(
                            color: Colors.grey.shade500,
                          ),
                        ),
                        // SizedBox(height: 20),
                        // _locationSearchSection(),
                        const SizedBox(height: 20),
                        CurrentWeatherComponent(
                          homeScreenController.model.value,
                        ),
                        const SizedBox(height: 20),
                        CurrentWeatherDetailsGridComponent(
                          model: homeScreenController.model.value,
                          color: aColor.brandDark2.color,
                          body1RegularTextStyle: body1RegularTextStyle,
                          caption2RegularTextStyle: caption2RegularTextStyle,
                        ),
                        const SizedBox(height: 20),
                        SunScheduleCardComponent(
                          color: aColor.brandDark2.color,
                          caption2RegularTextStyle: caption2RegularTextStyle,
                          convertTimeStampToHumanHour:
                              homeScreenController.convertTimeStampToHumanHour,
                          model: homeScreenController.model.value,
                          isItDayNow:
                              (homeScreenController.model.value.current !=
                                      null) &&
                                  homeScreenController.isItDayNow(),
                        ),
                        const SizedBox(height: 20),
                        HourlyWeatherForecastComponent(
                          color: aColor.brandDark2.color,
                          convertTimeStampToHumanHour:
                              homeScreenController.convertTimeStampToHumanHour,
                          model: homeScreenController.model.value,
                        ),
                        const SizedBox(height: 20),
                        WeeklyWeatherForecastComponent(
                          convertTimeStampToHumanDateMonth: homeScreenController
                              .convertTimeStampToHumanDateMonth,
                          convertTimeStampToHumanDay:
                              homeScreenController.convertTimeStampToHumanDay,
                          model: homeScreenController.model.value,
                          color: aColor.brandDark2.color,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Container _locationSearchSection() => Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
          color: aColor.brandDark2.color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Location",
                style: body2RegularTextStyle,
              ),
              const Icon(Icons.search, color: Colors.white),
            ],
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
