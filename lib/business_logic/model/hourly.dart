// ignore_for_file: always_use_package_imports, unnecessary_new, avoid_dynamic_calls, prefer_collection_literals
import 'weather.dart';

class Hourly {
  dynamic dt;
  dynamic temp;
  dynamic feelsLike;
  dynamic weather;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.weather,
  });

  Hourly.fromJson(Map<String, dynamic> json) {
    dt = json['dt'] as int?;
    temp = (json['temp'] != null) ? double.parse("${json['temp']}") : null;
    feelsLike = (json['feels_like'] != null)
        ? double.parse("${json['feels_like']}")
        : null;
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = dt;
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
