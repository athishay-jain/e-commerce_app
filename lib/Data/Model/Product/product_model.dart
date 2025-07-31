class ProductModel {
  int id;
  String name;
  String price;
  String image;
  dynamic category_id;
  dynamic status;
  String created_at;
  String updated_at;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category_id,
    required this.created_at,
    required this.status,
    required this.updated_at,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] is String?int.parse(json['id']):json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      category_id: json['category_id'],
      created_at: json['created_at'],
      status: json['status'],
      updated_at: json['updated_at'],
    );
  }
}

class ProductDataModel {
  bool status;
  String message;
  List<ProductModel> data;

  ProductDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    List<ProductModel> data = [];
    for (Map<String, dynamic> eachJson in json["data"]) {
      data.add(ProductModel.fromJson(eachJson));
    }
    return ProductDataModel(
      status: json['status'],
      message: json['message'],
      data: data,
    );
  }
}
