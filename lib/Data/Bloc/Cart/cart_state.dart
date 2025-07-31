import 'package:ecommerce_app/Data/Model/Product/cart_model.dart';

abstract class CartState{}
class InitialState extends CartState{}
class LoadingState extends CartState{}
class SuccessState extends CartState{
  String message;
  SuccessState({required this.message});
}
class LoadedState extends CartState{
  List<CartModel>cart;
  int totalAmount;
  LoadedState({required this.cart,required this.totalAmount});
}
class FailureState extends CartState{
  String errorMessage;
  FailureState({required this.errorMessage});
}