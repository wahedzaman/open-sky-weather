// ignore_for_file: always_use_package_imports, depend_on_referenced_packages

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:open_sky_weather/config.dart';

import 'business_logic/core/constants.dart';
import 'business_logic/utilities/utility.dart';
import 'ui/screens/splash/splash_screen.dart';

// ignore: avoid_void_async
void main() async {
  Config();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Utility()); //.determinePosition();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit(
        // designSize: Size(360, 720),
        // designSize: Size(2400, 1800),
        builder: (context, child) {
          return GetMaterialApp(
            theme: ThemeData(
              fontFamily: 'Metropolis',
            ),
            debugShowCheckedModeBanner: false,
            title: appName,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
