class UploadItemModel {
  late String id;
  late String name;
  late int price;
  late String condition;
  late double weight;
  late String filename;

  UploadItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.condition,
    required this.weight,
    required this.filename,
  });

  UploadItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    condition = json['condition'];
    weight = json['weight'];
    filename = json['filename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['condition'] = this.condition;
    data['weight'] = this.weight;
    data['filename'] = this.filename;
    return data;
  }
}
