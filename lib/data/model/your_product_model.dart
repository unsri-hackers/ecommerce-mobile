class YourProduct {
  late int? id;
  late String? rating;
  late String? title;
  late String? price;
  late String? photo;

  YourProduct({this.id, this.rating, this.title, this.price, this.photo});

  YourProduct.fromJson(Map<String, dynamic> json) {
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
