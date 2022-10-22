// ignore: constant_identifier_names

// ignore_for_file: constant_identifier_names, duplicate_ignore

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:open_sky_weather/business_logic/utilities/utility.dart';

const String _BASE_URL = "https://api.openweathermap.org/data";

const String _APP_URL = "app_server_url";
//register and get an api key from https://api.openweathermap.org/data
const String appId = "your_api_key";
String getBaseURL() {
  return _BASE_URL;
}

String getTeamAPIEndPoint() {
  return "${_APP_URL}team.php";
}

String getLogAPIEndPoint(String firebaseId, int platform) {
  return _APP_URL;
}

String getOneCallAPI({bool isGPSCall = true}) {
  var userLocation = "";
  // debugPrint("has location: ${Get.put(Utility()).hasLocation()}");
  if (isGPSCall && Get.put(Utility()).hasLocation()) {
    final Position userPosition = Get.find<Utility>().position;
    userLocation =
        "&lat=${userPosition.latitude}&lon=${userPosition.longitude}";
  }
  return "$_BASE_URL/2.5/onecall?appid=$appId&units=metric&exclude=minutely$userLocation";
}
