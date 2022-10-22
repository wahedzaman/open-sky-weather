// ignore_for_file: always_use_package_imports

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:open_sky_weather/business_logic/core/api_enpoints.dart';
import 'package:open_sky_weather/business_logic/model/model.dart';
import '../network_manager.dart';

class OpenWeatherAPI {
  NetworkManager networkManager = Get.find(tag: "network");

  Future<Model?> getWeatherDetails() async {
    Model? model;
    await networkManager
        .sendGetRequest(getOneCallAPI())
        .onError((error, stackTrace) {
      return Future.error(error!);
    }).then((response) {
      debugPrint(response.toString());
      // ignore: avoid_dynamic_calls
      model = Model.fromJson(response.data as Map<String, dynamic>);
    });
    if (model != null) {
      debugPrint("looks good from api: 😍😘");
    } else {
      debugPrint("error??? bad developer 😪");
    }
    return model;
  }
}
