// ignore: always_use_package_imports
// ignore_for_file: avoid_dynamic_calls, prefer_collection_literals

// ignore: always_use_package_imports
import 'weather.dart';

class Current {
  dynamic dt;
  dynamic sunrise;
  dynamic sunset;
  dynamic temp;
  dynamic feelsLike;
  dynamic pressure;
  dynamic humidity;
  dynamic dewPoint;
  dynamic uvi;
  dynamic clouds;
  dynamic visibility;
  dynamic windDeg;
  dynamic windSpeed;
  List<Weather>? weather;

  int getDt() => dt == null ? 0 : (dt! as int);
  int getSunrise() => sunrise == null ? 0 : (sunrise! as int);
  int getSunset() => sunset == null ? 0 : (sunset! as int);
  int getPressure() => pressure == null ? 0 : (pressure! as int);
  int getHumidity() => humidity == null ? 0 : (humidity! as int);
  int getClouds() => clouds == null ? 0 : (clouds! as int);
  int getVisibility() => visibility == null ? 0 : (visibility! as int);
  int getWindDeg() => windDeg == null ? 0 : (windDeg! as int);
  double getTemp() => temp == null ? 0.0 : (temp! as double);
  double getFeelsLike() => feelsLike == null ? 0.0 : (feelsLike! as double);
  double getDewPoint() => dewPoint == null ? 0.0 : (dewPoint! as double);
  double getUvi() => uvi == null ? 0.0 : (uvi! as double);
  double getWindSpeed() => windSpeed == null ? 0.0 : (windSpeed! as double);
  List<Weather>? getWeather() => weather == null ? null : weather!;

  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windDeg,
    this.windSpeed,
    this.weather,
  });

  Current.fromJson(Map<String, dynamic> json) {
    dt = json['dt'] as int?;
    sunrise = json['sunrise'] as int?;
    sunset = json['sunset'] as int?;
    temp = (json['temp'] != null) ? double.parse("${json['temp']}") : null;
    feelsLike = (json['feels_like'] != null)
        ? double.parse("${json['feels_like']}")
        : null;
    pressure = json['pressure'] as int?;
    humidity = json['humidity'] as int?;
    dewPoint = json['dew_point'] as double?;
    uvi = (json['uvi'] != null) ? double.parse("${json['uvi']}") : null;
    clouds = json['clouds'] as int?;
    visibility = json['visibility'] as int?;
    windDeg = json['wind_deg'] as int?;
    windSpeed = (json['wind_speed'] != null)
        ? double.parse("${json['wind_speed']}")
        : null;
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dt'] = dt;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['dew_point'] = dewPoint;
    data['uvi'] = uvi;
    data['clouds'] = clouds;
    data['visibility'] = visibility;
    data['wind_deg'] = windDeg;
    data['wind_speed'] = windSpeed;
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
