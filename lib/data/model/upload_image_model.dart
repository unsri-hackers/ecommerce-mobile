class UploadImageModel {
  String? path;
  String? name;
  
  UploadImageModel({this.path, this.name});

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['name'] = this.name;
    return data;
  }
}