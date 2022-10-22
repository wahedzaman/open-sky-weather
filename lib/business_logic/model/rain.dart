// ignore_for_file: prefer_initializing_formals

class Rain {
  dynamic d1h;

  Rain({double d1h = 0.0}) {
    this.d1h = d1h;
  }

  Rain.fromJson(Map<String, dynamic> json) {
    d1h = json['1h'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1h'] = d1h;
    return data;
  }
}
