class UploadImageModel {
  String? image_url;
  
  UploadImageModel({this.image_url});

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    image_url = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.image_url;
    return data;
  }
}