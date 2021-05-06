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
