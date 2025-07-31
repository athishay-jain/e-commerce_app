import 'package:ecommerce_app/Data/Model/Product/cart_model.dart';

abstract class CartEvent{}
class AddToCart extends CartEvent{
  int product_id;
  int quantity;
  AddToCart({required this.quantity,required this.product_id});
}
class GetCart extends CartEvent{
}
class DeleteItem extends CartEvent{
  int cart_id;
  DeleteItem({required this.cart_id});
}
class IncrementQty extends CartEvent{
  int product_id;
  int quantity;
  IncrementQty({required this.product_id,required this.quantity});
}
class DecrementQty extends CartEvent{
  int product_id;
  int quantity;
  DecrementQty({required this.quantity,required this.product_id});
}
class PlaceOrder extends CartEvent{
  int cart_id;
  PlaceOrder({required this.cart_id});
}