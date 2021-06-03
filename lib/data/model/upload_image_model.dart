class UploadImageModel {
  late String? image_name;

  UploadImageModel({this.image_name});

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    image_name = json['image_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_name'] = this.image_name;
    return data;
  }
}