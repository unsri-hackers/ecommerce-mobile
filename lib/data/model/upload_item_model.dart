class UploadItemModel {
  String? id;
  String? name;
  int? price;
  String? category;
  String? variant;
  String? condition;
  double? weight;
  int? stock;
  String? description;
  List<String>? imageurls;

  UploadItemModel({
    this.id,
    this.name,
    this.price,
    this.category,
    this.variant,
    this.condition,
    this.weight,
    this.description,
    this.stock,
    this.imageurls,
  });

  UploadItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    category = json['category'];
    variant = json['variant'];
    condition = json['condition'];
    weight = json['weight'];
    stock = json['stock'];
    description = json['description'];
    imageurls = json['imageurls'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['category'] = this.category;
    data['variant'] = this.variant;
    data['condition'] = this.condition;
    data['weight'] = this.weight;
    data['stock'] = this.stock;
    data['description'] = this.description;
    data['imageurls'] = this.imageurls;
    return data;
  }
}
