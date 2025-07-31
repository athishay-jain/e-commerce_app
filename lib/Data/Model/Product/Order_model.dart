class OrderResponseDataModel {
  final bool status;
  final String message;
  final List<OrderResponseModel> orders;

  OrderResponseDataModel({
    required this.status,
    required this.message,
    required this.orders,
  });

  factory OrderResponseDataModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseDataModel(
      status: json['status'],
      message: json['message'],
      orders: List<OrderResponseModel>.from(
        json['orders'].map((order) => OrderResponseModel.fromJson(order)),
      ),
    );
  }
}

class OrderResponseModel {
  final int id;
  final String totalAmount;
  final String orderNumber;
  final String status;
  final String createdAt;
  final List<OrderModel> product;

  OrderResponseModel({
    required this.id,
    required this.totalAmount,
    required this.orderNumber,
    required this.status,
    required this.createdAt,
    required this.product,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      id: json['id'],
      totalAmount: json['total_amount'],
      orderNumber: json['order_number'],
      status: json['status'],
      createdAt: json['created_at'],
      product: List<OrderModel>.from(
        json['product'].map((item) => OrderModel.fromJson(item)),
      ),
    );
  }
}

class OrderModel {
  final int id;
  final String name;
  final int quantity;
  final String price;
  final String image;

  OrderModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      image: json['image'],
    );
  }
}
