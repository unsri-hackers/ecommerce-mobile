class HomeModel {
  late List<OngoingOrders>? ongoingOrders;
  late List<ProductCategories>? productCategories;
  late List<YourProducts>? yourProducts;

  HomeModel({this.ongoingOrders, this.productCategories, this.yourProducts});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['ongoingOrders'] != null) {
      ongoingOrders = <OngoingOrders>[];
      json['ongoingOrders'].forEach((v) {
        ongoingOrders!.add(new OngoingOrders.fromJson(v));
      });
    }
    if (json['productCategories'] != null) {
      productCategories = <ProductCategories>[];
      json['productCategories'].forEach((v) {
        productCategories!.add(new ProductCategories.fromJson(v));
      });
    }
    if (json['yourProducts'] != null) {
      yourProducts = <YourProducts>[];
      json['yourProducts'].forEach((v) {
        yourProducts!.add(new YourProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ongoingOrders != null) {
      data['ongoingOrders'] =
          this.ongoingOrders!.map((v) => v.toJson()).toList();
    }
    if (this.productCategories != null) {
      data['productCategories'] =
          this.productCategories!.map((v) => v.toJson()).toList();
    }
    if (this.yourProducts != null) {
      data['yourProducts'] = this.yourProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OngoingOrders {
  late int? id;
  late String? title;
  late String? date;
  late List<String>? photos;

  OngoingOrders({this.id, this.title, this.date, this.photos});

  OngoingOrders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    photos = json['photos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['photos'] = this.photos;
    return data;
  }
}

class ProductCategories {
  late int? id;
  late String? title;
  late String? photo;

  ProductCategories({this.id, this.title, this.photo});

  ProductCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['photo'] = this.photo;
    return data;
  }
}

class YourProducts {
  late int? id;
  late String? rating;
  late String? title;
  late String? price;
  late String? photo;

  YourProducts({this.id, this.rating, this.title, this.price, this.photo});

  YourProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rating = json['rating'];
    title = json['title'];
    price = json['price'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rating'] = this.rating;
    data['title'] = this.title;
    data['price'] = this.price;
    data['photo'] = this.photo;
    return data;
  }
}
