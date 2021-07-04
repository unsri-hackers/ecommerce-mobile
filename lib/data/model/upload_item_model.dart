import 'package:deuvox/data/model/upload_image_model.dart';

class UploadItemModel {
  String? productName;
  String? price;
  List<dynamic>? photos;

  UploadItemModel({
    this.productName,
    this.price,
    this.photos,
  });

  UploadItemModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    price = json['price'];
    photos = json['photos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['price'] = this.price;
    data['photos'] = this.photos;
    return data;
  }
}
