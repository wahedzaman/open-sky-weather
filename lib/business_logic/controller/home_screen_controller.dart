// ignore_for_file: non_constant_identifier_names, unused_element

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:open_sky_weather/business_logic/core/service_locator.dart';
import 'package:open_sky_weather/business_logic/model/model.dart';
import 'package:open_sky_weather/business_logic/utilities/utility.dart';
import 'package:open_sky_weather/services/api/aflion_analytic_api.dart';
import 'package:open_sky_weather/services/api/open_weather_api.dart';

class HomeScreenController extends GetxController {
  final OpenWeatherAPI _weatherAPI = serviceLocator<OpenWeatherAPI>();
  final AflionAnalyticsAPI _analyticsAPI = serviceLocator<AflionAnalyticsAPI>();
  final storage = GetStorage();
  final int REFRESH_TIME_DELTA_HOUR = 0;
  final int REFRESH_TIME_DELTA_MIN = 2;

  Utility utility = serviceLocator<Utility>();
  RxBool hasError = false.obs;
  RxBool noDataRecords = false.obs;
  Rx<Model> model = Model().obs;

  // ignore: always_declare_return_types, type_annotate_public_apis
  init() {}
  String convertTimeStampToHumanHour(int timeStamp) {
    final dateToTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('hh:mm a').format(dateToTimeStamp);
  }

  String convertTimeStampToHumanDay(int timeStamp) {
    final dateToTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('EEE').format(dateToTimeStamp);
  }

  String convertTimeStampToHumanDateMonth(int timeStamp) {
    final dateToTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('MMM d').format(dateToTimeStamp);
  }

  bool isItDayNow() {
    final int sunrise = model.value.getCurrent()!.getSunrise();
    final int sunset = model.value.getCurrent()!.getSunset();
    final int currentTime =
        int.parse("${DateTime.now().millisecondsSinceEpoch}".substring(0, 10));
    return currentTime >= sunrise && currentTime <= sunset;
  }

  double _determineSunPosition() {
    final int sunrise = model.value.getCurrent()!.getSunrise();
    final int sunset = model.value.getCurrent()!.getSunset();
    final int currentTime =
        int.parse("${DateTime.now().millisecondsSinceEpoch}".substring(0, 10));
    debugPrint("sunris: $sunrise");
    debugPrint("sunset: $sunset");
    debugPrint("curren: $currentTime");
    final double percent = (sunset - currentTime) / 10;
    debugPrint("percent: $percent");
    return 0.7;
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> callLoggingAPI() async {
    debugPrint("callling logging api");
    // final fcmToken = await FirebaseMessaging.instance.getToken();
    // if (await utility.hasInternetConnectivity()) {
    //   await _analyticsAPI.logAppOpening(fcmToken!, 1);
    // }
  }

  Future<void> callAPI() async {
    debugPrint("callling api");
    if (canCallAPI()) {
      if (await utility.hasInternetConnectivity()) {
        debugPrint("has internet");
        await _weatherAPI.getWeatherDetails().then((value) {
          debugPrint("looks good:3 👍🏼");
          model.value = value!;
          hasError.value = false;
          _saveModelJsonStringToGetStorage(value);
          update();
        }).onError((error, stackTrace) {
          debugPrintStack(stackTrace: stackTrace);
          //todo:: custom callback to slack api
          debugPrint("error from homescreenController :${error.toString()}");
          hasError.value = true;
          update();
        });
      } else {
        debugPrint("No Internet");
        Get.snackbar(
          "No Internet!",
          "Please connect to internet!",
          duration: const Duration(seconds: 5),
          overlayBlur: 10,
        );
      }
    } else {
      debugPrint("Can't call API! Loading from storage");
      _prepareDataFromLocalStorage();
    }
  }

  void _prepareDataFromLocalStorage() {
    model.value = _getModelFromGetStorage();
    hasError.value = true;
    update();
  }

  bool canCallAPI() {
    if (hasData()) return timeLimitExpired();
    return true;
  }

  bool _saveModelJsonStringToGetStorage(Model model) {
    storage.write("last_JsonData", jsonEncode(model));
    _saveLastCallTime();
    return true;
  }

  bool hasData() {
    final json = storage.read("last_JsonData");
    return json != null;
  }

  bool timeLimitExpired() {
    final DateTime lastCallTimeFormatted = DateTime.parse(_getLastCallTime());
    final int timeDelta =
        DateTime.now().difference(lastCallTimeFormatted).inMilliseconds;
    return timeDelta >
        ((REFRESH_TIME_DELTA_HOUR * 60) + REFRESH_TIME_DELTA_MIN) * 60 * 1000;
  }

  Model _getModelFromGetStorage() {
    final String jsonString = storage.read("last_JsonData") as String;
    return Model.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  }

  String _getLastCallTime() {
    return storage.read('last_call_time') ?? "0";
  }

  Future<void> _saveLastCallTime() {
    return storage.write("last_call_time", DateTime.now().toString());
  }
}
