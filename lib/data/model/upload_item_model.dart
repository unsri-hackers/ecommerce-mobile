class UploadItemModel {
  String? id;
  String? name;
  double? price;
  String? condition;
  double? weight;
  String? description;
  String? filename;

  UploadItemModel({
    this.id,
    this.name,
    this.price,
    this.condition,
    this.weight,
    this.description,
    this.filename,
  });

  UploadItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    condition = json['condition'];
    weight = json['weight'];
    description = json['description'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['condition'] = this.condition;
    data['weight'] = this.weight;
    data['description'] = this.description;
    data['filename'] = this.filename;
    return data;
  }
}
