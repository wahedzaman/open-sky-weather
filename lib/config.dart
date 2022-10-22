import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_sky_weather/business_logic/core/service_locator.dart';
import 'package:open_sky_weather/my_http_overrides.dart';

class Config {
  Config() {
    HttpOverrides.global = MyHttpOverrides();
    WidgetsFlutterBinding.ensureInitialized();
    _initGETX();
    _initFirebase();
    _initAppSettings();
    setupServiceLocator();
  }

  void _initAppSettings() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> _initFirebase() async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    // await FirebaseAnalytics.instance.logAppOpen();
  }

  Future<void> _initGETX() async {
    await GetStorage.init();
  }
}
