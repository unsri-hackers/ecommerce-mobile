class UserModel {
  late int id;
  late String? name;
  late String? authtoken;
  late String? fcmToken;

  UserModel({required this.id, this.name, this.authtoken, this.fcmToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    authtoken = json['authtoken'];
    fcmToken = json['fcmToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['authtoken'] = this.authtoken;
    data['fcmToken'] = this.fcmToken;
    return data;
  }

  UserModel copyWith(
      {required int id, String? name, String? authtoken, String? fcmToken}) {
    return UserModel(
        id: this.id,
        name: name ?? this.name,
        authtoken: authtoken ?? this.authtoken,
        fcmToken: fcmToken ?? this.fcmToken);
  }
}


class UserSessionModel {
  late String? accessToken;
  late String? tokenType;
  late String? username;

  UserSessionModel({this.accessToken, this.tokenType, this.username});

  UserSessionModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['tokenType'] = this.tokenType;
    data['username'] = this.username;
    return data;
  }

  UserSessionModel copyWith(
      { String? accessToken, String? tokenType, String? username}) {
    return UserSessionModel(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        username: username ?? this.username);
  }
}
