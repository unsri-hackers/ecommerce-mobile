import 'package:deuvox/data/model/upload_image_model.dart';

class UploadItemModel {
  String? productName;
  String? price;
  List<ProductPhotoModel>? photos;

  UploadItemModel({
    this.productName,
    this.price,
    this.photos,
  });

  UploadItemModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    price = json['price'];
    if (json['photos'] != null) {
      photos =  <ProductPhotoModel>[];
      json['photos'].forEach((v) {
        photos!.add(new ProductPhotoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['price'] = this.price;
     if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductPhotoModel {
  String? path;
  String? name;

  ProductPhotoModel({
    this.path,
    this.name,
  });

  ProductPhotoModel.fromJson(Map<String, dynamic> json) {
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

