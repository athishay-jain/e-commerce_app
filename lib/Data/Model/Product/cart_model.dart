class CartModel {
  int id;
  int product_id;
  String name;
  String price;
  int quantity;
  String image;

  CartModel({
    required this.quantity,
    required this.image,
    required this.price,
    required this.name,
    required this.id,
    required this.product_id,
  });

  factory CartModel.fromMap(Map<String, dynamic> json) {
    return CartModel(
      quantity: json["quantity"],
      image: json['image'],
      price: json['price'],
      name: json['name'],
      id: json['id'],
      product_id: json['product_id'],
    );
  }
}

class CartDataModel {
  bool status;
  String message;
  List<CartModel> data;

  CartDataModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory CartDataModel.fromMap(Map<String, dynamic> json) {
    List<CartModel> data = [];
    for (Map<String, dynamic> eachJson in json['data']) {
      data.add(CartModel.fromMap(eachJson));
    }
    return CartDataModel(
      data: data,
      message: json["message"],
      status: json['status'],
    );
  }
}
