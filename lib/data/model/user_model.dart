class UserModel {
  late String id;
  late String? name;
  late String? avatar;

  UserModel({required this.id, this.name, this.avatar});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['sellerId'];
    name = json['sellerName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellerId'] = this.id;
    data['sellerName'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }

  UserModel copyWith(
      {required int id, String? name, String? avatar}) {
    return UserModel(
      id: this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}

class UserSessionModel {
  late int id;
  late String? accessToken;
  late String? tokenType;
  late String? username;

  UserSessionModel(
      {required this.id, this.accessToken, this.tokenType, this.username});

  UserSessionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accessToken'] = this.accessToken;
    data['tokenType'] = this.tokenType;
    data['username'] = this.username;
    return data;
  }

  UserSessionModel copyWith(
      {int? id, String? accessToken, String? tokenType, String? username}) {
    return UserSessionModel(
        id: id ?? this.id,
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        username: username ?? this.username);
  }
}
