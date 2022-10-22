// ignore_for_file: always_use_package_imports, unnecessary_new, avoid_dynamic_calls, prefer_collection_literals

import 'temp.dart';
import 'weather.dart';

class Daily {
  dynamic dt;
  dynamic temp;
  dynamic weather;

  Daily({
    this.dt,
    this.temp,
    this.weather,
  });

  Daily.fromJson(Map<String, dynamic> json) {
    dt = json['dt'] as int?;
    temp = json['temp'] != null
        ? Temp.fromJson(json['temp'] as Map<String, dynamic>)
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
    if (temp != null) {
      data['temp'] = temp!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
