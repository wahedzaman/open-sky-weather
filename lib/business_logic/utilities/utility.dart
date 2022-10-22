import 'dart:io';

// import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:vibration/vibration.dart';

//todo: implement firebase id into the payload
class Utility extends WidgetsBindingObserver {
  // static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  bool deviceHasVibratorMotor = false;
  bool _gotUserLocation = false;
  RxString userLocationAddress = "Tap here to grant Location Permission!".obs;
  RxString dummyEmptyText = "".obs;

  late Position position;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  bool currentSystemTheme() {
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    final bool darkModeOn = brightness == Brightness.dark;
    return darkModeOn;
  }

  Utility() {
    _hasVibrator();
  }

  bool hasLocation() => _gotUserLocation;

  Future<void> _hasVibrator() async {
    deviceHasVibratorMotor = (await Vibration.hasVibrator())!;
  }

  Future<void> openAppSettings() async {
    final opened = await _geolocatorPlatform.openAppSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Application Settings.';
    } else {
      displayValue = 'Error opening Application Settings.';
    }
    debugPrint(displayValue);
  }

  Future<bool> askForPosition({bool buttonClicked = false}) async {
    bool result = false;
    final LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      if (!Get.find<Utility>().hasLocation()) {
        if (buttonClicked) await Get.find<Utility>().openAppSettings();
      }
      return false;
    }

    if ((permission == LocationPermission.always) ||
        (permission == LocationPermission.whileInUse)) {
      determinePosition();
      return true;
    }

    Get.defaultDialog(
      titlePadding: const EdgeInsets.all(15),
      titleStyle: const TextStyle(
        fontFamily: 'Metropolis',
        fontSize: 22,
      ),
      middleTextStyle: const TextStyle(
        fontFamily: 'Metropolis',
        fontSize: 18,
      ),
      contentPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      title: "Permission Request",
      textConfirm: "Okay",
      textCancel: "Later",
      barrierDismissible: false,
      buttonColor: Colors.black,
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      middleText:
          "Open Sky Weather App needs Location Permission to show you weather information near your place",
      onCancel: () {
        //close app
        result = false;
        if (Platform.isIOS) {
          exit(0);
        } else {
          SystemNavigator.pop();
        }
      },
      onConfirm: () {
        result = true;
        determinePosition();
        Get.back();
      },
    );
    return result;
  }

  Future<Position> determinePosition() async {
    _gotUserLocation = false;
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
    } catch (e) {
      debugPrint(e.toString());
      serviceEnabled = false;
    }
    if (!serviceEnabled) {
      //todo:: show dialog
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //todo:: show dialog
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //todo:: show dialog
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    Get.defaultDialog(
      barrierDismissible: false,
      titlePadding: const EdgeInsets.all(15),
      titleStyle: const TextStyle(
        fontFamily: 'Metropolis',
        fontSize: 22,
      ),
      middleTextStyle: const TextStyle(
        fontFamily: 'Metropolis',
        fontSize: 18,
      ),
      contentPadding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
      ),
      title: "Requesting Data!",
      buttonColor: Colors.black,
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      middleText: "Please Wait!",
      content: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    );

    position = await Geolocator.getCurrentPosition();
    debugPrint("${position.latitude}");
    debugPrint("${position.longitude}");
    //below line will cause exception if network not available. BP: check network before proceed
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: "en",
    );
    _gotUserLocation = true;
    // Get.back(result: dialog);
    Navigator.of(Get.overlayContext!).pop();
    userLocationAddress.value =
        "${placemarks[0].locality} ${placemarks[0].subLocality}".trim();
    debugPrint("user location : ${userLocationAddress.value}");
    // ignore: avoid_function_literals_in_foreach_calls
    placemarks.forEach((element) {
      debugPrint("location data: ${element.toJson()}");
      debugPrint("----");
      debugPrint("total: ${placemarks.length}");
    });
    return position;
  }

  Future<bool> hasInternetConnectivity() async {
    try {
      final bool result = await InternetConnectionChecker().hasConnection;
      if (result == true) {
        debugPrint('connected');
        return Future.value(true);
      }
    } on SocketException catch (_) {
      debugPrint('not connected');
    }
    return Future.value(false);
  }

  void vibrate() {
    if (deviceHasVibratorMotor) {
    } else {
      debugPrint("no vibration motor found");
    }
  }

  Future<int?> getPatformType() async {
    try {
      if (Platform.isAndroid) {
        return 1;
      } else if (Platform.isIOS) {
        return 2;
      }
    } on PlatformException {
      debugPrint('Failed to get platform type.');
    }
    return null;
  }
}
