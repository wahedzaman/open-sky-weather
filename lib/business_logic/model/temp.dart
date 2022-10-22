// ignore_for_file: prefer_initializing_formals

class Temp {
  dynamic day;
  dynamic min;
  dynamic max;
  dynamic night;
  dynamic eve;
  dynamic morn;

  Temp({
    double day = 0.0,
    double min = 0.0,
    double max = 0,
    double night = 0.0,
    double eve = 0.0,
    double morn = 0.0,
  }) {
    this.day = day;
    this.min = min;
    this.max = max;
    this.night = night;
    this.eve = eve;
    this.morn = morn;
  }

  Temp.fromJson(Map<String, dynamic> json) {
    day = (json['day'] != null) ? double.parse("${json['day']}") : null;
    // day = json['day'];
    min = (json['min'] != null) ? double.parse("${json['min']}") : null;
    // min = json['min'];
    max = (json['max'] != null) ? double.parse("${json['max']}") : null;
    // max = json['max'];
    night = (json['night'] != null) ? double.parse("${json['night']}") : null;
    // night = json['night'];
    eve = (json['eve'] != null) ? double.parse("${json['eve']}") : null;
    // eve = json['eve'];
    morn = (json['morn'] != null) ? double.parse("${json['morn']}") : null;
    // morn = json['morn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['min'] = min;
    data['max'] = max;
    data['night'] = night;
    data['eve'] = eve;
    data['morn'] = morn;
    return data;
  }
}
