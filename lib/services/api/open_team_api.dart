// ignore_for_file: always_use_package_imports

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:open_sky_weather/business_logic/model/team.dart';
import '../../business_logic/core/api_enpoints.dart';
import '../network_manager.dart';

class OpenTeamAPI {
  NetworkManager networkManager = Get.find(tag: "network");

  Future<List<Team>> getTeamDetails() async {
    List<Team>? teamList;
    await networkManager
        .sendGetRequest(getTeamAPIEndPoint())
        .onError((error, stackTrace) {
      return Future.error(error!);
    }).then((response) {
      final jsonResponse = json.decode(response!.toString());
      // ignore: avoid_dynamic_calls
      final team = jsonResponse['team'] as List;
      teamList = team
          .map((data) => Team.fromJson(data as Map<String, dynamic>))
          .toList();
    });
    if (teamList != null) {
      debugPrint("looks good from api: 😍😘");
    } else {
      debugPrint("error??? bad developer 😪");
    }
    return teamList!;
  }
}
