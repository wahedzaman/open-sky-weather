import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:open_sky_weather/business_logic/core/service_locator.dart';
import 'package:open_sky_weather/business_logic/model/team.dart';
import 'package:open_sky_weather/business_logic/utilities/utility.dart';
import 'package:open_sky_weather/services/api/open_team_api.dart';

class TeamScreenController extends GetxController {
  final OpenTeamAPI _teamAPI = serviceLocator<OpenTeamAPI>();

  Utility utility = serviceLocator<Utility>();
  RxBool hasError = false.obs;

  List<Team> teamList = [];

  Future<void> callAPI() async {
    debugPrint("callling api");

    if (await utility.hasInternetConnectivity()) {
      debugPrint("has internet");
      await _teamAPI.getTeamDetails().then((value) {
        debugPrint("looks good:3 👍🏼");
        teamList = value;
        hasError.value = false;
        update();
      }).onError((error, stackTrace) {
        debugPrint("error: from SettingsScreenController");
        debugPrintStack(stackTrace: stackTrace);
        debugPrint("error:${error.toString()}");
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
  }
}
