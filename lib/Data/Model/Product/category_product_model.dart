class CategoryProductModel {
  int id;
  String name;
  String price;
  String image;
  int category_id;
  int status;
  String created_at;
  String updated_at;

  CategoryProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category_id,
    required this.created_at,
    required this.status,
    required this.updated_at,
  });

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) {
    return CategoryProductModel(
      id: json['id'],
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

class CategoryProductDataModel {
  bool status;
  String message;
  List<CategoryProductModel> data;

  CategoryProductDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryProductDataModel.fromJson(Map<String, dynamic> json) {
    List<CategoryProductModel> data = [];
    if(json["data"]!=null){
      for (Map<String, dynamic> eachJson in json["data"]) {
        data.add(CategoryProductModel.fromJson(eachJson));
      }
    }
    return CategoryProductDataModel(
      status: json['status'],
      message: json['message'],
      data: data,
    );
  }
}
