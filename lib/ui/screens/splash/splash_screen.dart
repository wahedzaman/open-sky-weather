// ignore_for_file: type_annotate_public_apis, always_declare_return_types

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_sky_weather/business_logic/controller/home_screen_controller.dart';
import 'package:open_sky_weather/business_logic/core/constants.dart';
import 'package:open_sky_weather/business_logic/utilities/app_theme.dart';
import 'package:open_sky_weather/business_logic/utilities/utility.dart';
import 'package:open_sky_weather/ui/screens/home/home_screen.dart';
import 'package:open_sky_weather/ui/widgets/dialogs.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();

  final HomeScreenController homeScreenController = Get.put(HomeScreenController());
}

class _SplashScreenState extends State<SplashScreen> {
  bool requestingPermission = false;
  final HomeScreenController homeScreenController = Get.put(HomeScreenController());
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      await Get.put(Utility()).askForPosition();
    });

    Get.put(Utility()).userLocationAddress.listen((value) {
      prepareData();
    });

    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        resumeCallBack: () {
          if (requestingPermission) Get.find<Utility>().determinePosition();
          requestingPermission = false;
          return Future(() => null);
        },
      ),
    );

    // Future.delayed(Duration(seconds: 3)).then((value) {
    //   Get.off(() => HomeScreen());
    // });
  }

  Future<void> prepareData() async {
    if (await Utility().hasInternetConnectivity()) {
      await homeScreenController.callLoggingAPI();
      await homeScreenController.callAPI();
      Get.off(() => HomeScreen());
    } else {
      showInformativeDialog(
        "No Internet!",
        "We can not connect with the remote server. Please try again later!",
        icon: "assets/icons/nonet.png",
        button: TextButton(
          onPressed: () {
            Navigator.of(Get.overlayContext!).pop();
            prepareData();
          },
          child: const Text("Retry"),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        color: aColor.brandDark2.color,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Stack(
            children: [
              Align(
                child: SvgPicture.asset(
                  "assets/logo.svg",
                  width: 128,
                  height: 128,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  appName,
                  style: subheading2MediumTextStyle.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        break;
    }
  }
}
