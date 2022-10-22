import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:open_sky_weather/business_logic/utilities/utility.dart';
import 'package:open_sky_weather/services/api/aflion_analytic_api.dart';
import 'package:open_sky_weather/services/api/open_team_api.dart';
import 'package:open_sky_weather/services/api/open_weather_api.dart';
import 'package:open_sky_weather/services/network_manager.dart';

GetIt serviceLocator = GetIt.instance;

// todo:: migrate to Getit all

void setupServiceLocator() {
  //core and utility
  serviceLocator.registerSingleton<Utility>(Utility());

  //network and apis
  Get.put(NetworkManager(), tag: "network");
  serviceLocator.registerLazySingleton<NetworkManager>(() => NetworkManager());
  serviceLocator.registerLazySingleton<OpenWeatherAPI>(() => OpenWeatherAPI());
  serviceLocator.registerLazySingleton<OpenTeamAPI>(() => OpenTeamAPI());
  serviceLocator
      .registerLazySingleton<AflionAnalyticsAPI>(() => AflionAnalyticsAPI());
}
