// ignore_for_file: always_use_package_imports

import 'package:get/get.dart';
import '../network_manager.dart';

class AflionAnalyticsAPI {
  NetworkManager networkManager = Get.find(tag: "network");

  Future<void> logAppOpening(String token, int platform) async {
    //code removed
  }
}
