import 'package:deuvox/data/model/upload_item_model.dart';
import 'package:easy_localization/easy_localization.dart';

class YourProduct {
  late String? sellerId;
  late String? sellerName;
  late String? productId;
  late String? productName;
  late double? price;
  late double? rating;
  late List<ProductPhotoModel>? photos = [];

  String? get priceFormatted {
    if (price == null) return null;
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return formatCurrency.format(price);
  }

  String? get ratingFormatted {
    return rating?.toStringAsFixed(1);
  }

  YourProduct(
      {this.sellerId,
      this.sellerName,
      this.productId,
      this.productName,
      this.price,
      this.rating,
      this.photos});

  YourProduct.fromJson(Map<String, dynamic> json) {
    sellerId = json['sellerId'];
    sellerName = json['sellerName'];
    productId = json['productId'];
    productName = json['productName'];
    price =
        json['price'] is int ? double.tryParse(json['price']) : json['price'];
    rating = json['rating'] is int
        ? double.tryParse(json['rating'])
        : json['rating'];

    if (json['photos'] != null) {
      photos = <ProductPhotoModel>[];
      json['photos'].forEach((v) {
        photos!.add(new ProductPhotoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellerId'] = this.sellerId;
    data['sellerName'] = this.sellerName;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['price'] = this.price;
    data['rating'] = this.rating;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
