// ignore_for_file: always_use_package_imports, unnecessary_new, avoid_dynamic_calls, prefer_collection_literals

import 'current.dart';
import 'daily.dart';
import 'hourly.dart';

class Model {
  dynamic lat;
  dynamic lon;
  dynamic timezone;
  dynamic timezoneOffset;
  dynamic current;
  List<Hourly>? hourly;
  List<Daily>? daily;

  double getLat() => lat == null ? 0.0 : (lat! as double);
  double getLon() => lon == null ? 0.0 : (lon! as double);
  String getTimeZone() => timezone == null ? "" : (timezone! as String);
  Current? getCurrent() => current == null ? null : (current! as Current);
  List<Hourly>? getHourly() => hourly == null ? null : hourly!;
  List<Daily>? getDaily() => daily == null ? null : daily!;

  Model({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.hourly,
    this.daily,
  });

  Model.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] as double?;
    lon = json['lon'] as double?;
    timezone = json['timezone'] as String?;
    timezoneOffset = json['timezone_offset'] as int?;
    current = json['current'] != null
        ? new Current.fromJson(json['current'] as Map<String, dynamic>)
        : null;
    if (json['hourly'] != null) {
      hourly = [];
      json['hourly'].forEach((v) {
        hourly!.add(new Hourly.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['daily'] != null) {
      daily = [];
      json['daily'].forEach((v) {
        daily!.add(new Daily.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = lat;
    data['lon'] = lon;
    data['timezone'] = timezone;
    data['timezone_offset'] = timezoneOffset;
    if (current != null) {
      data['current'] = current!.toJson();
    }
    if (hourly != null) {
      data['hourly'] = hourly!.map((v) => v.toJson()).toList();
    }
    if (daily != null) {
      data['daily'] = daily!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
