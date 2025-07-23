class CategoriesModel {
  String id;
  String name;
  String status;
  String created_at;
  String updated_at;

  CategoriesModel({
    required this.id,
    required this.name,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}

class CategoriesDataModel {
  bool status;
  String message;
  List<CategoriesModel> data;

  CategoriesDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    List<CategoriesModel> data = [];
    for (Map<String, dynamic> eachJson in json["data"]) {
      data.add(CategoriesModel.fromJson(eachJson));
    }
    return CategoriesDataModel(
      status: json['status'],
      message: json['message'],
      data: data,
    );
  }
}
