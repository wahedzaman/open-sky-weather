class Team {
  String? name;
  String? type;
  String? bio;
  String? avatar;
  String? web;
  String? email;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? instagram;

  Team({
    this.name,
    this.type,
    this.bio,
    this.avatar,
    this.web,
    this.email,
    this.facebook,
    this.twitter,
    this.linkedin,
    this.instagram,
  });

  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    type = json['type'] as String?;
    bio = json['bio'] as String?;
    avatar = json['avatar'] as String?;
    web = json['web'] as String?;
    email = json['email'] as String?;
    facebook = json['facebook'] as String?;
    twitter = json['twitter'] as String?;
    linkedin = json['linkedin'] as String?;
    instagram = json['instagram'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //  final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['type'] = type;
    data['bio'] = bio;
    data['avatar'] = avatar;
    data['web'] = web;
    data['email'] = email;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['linkedin'] = linkedin;
    data['instagram'] = instagram;
    return data;
  }
}
