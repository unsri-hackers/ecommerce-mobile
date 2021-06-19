class OngoingOrder {
  late int? id;
  late String? sellerName;
  late String? productName;
  late String? dueDate;
  late double? price;
  late List<String>? photos;

  OngoingOrder({
    this.id,
    this.sellerName,
    this.productName,
    this.dueDate,
    this.price,
    this.photos,
  });

  OngoingOrder.fromJson(Map<String, dynamic> json) {
    id = json['productId'];
    sellerName = json['sellerName'];
    productName = json['productName'];
    dueDate = json['dueDate'];
    price = json['price'];
    photos = json['photos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.id;
    data['productName'] = this.productName;
    data['dueDate'] = this.dueDate;
    data['sellerName'] = this.sellerName;
    data['price'] = this.price;
    data['photos'] = this.photos;
    return data;
  }
}
