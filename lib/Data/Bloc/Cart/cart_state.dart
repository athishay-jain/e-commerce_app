import 'package:ecommerce_app/Data/Model/Product/cart_model.dart';

abstract class CartState {}

class InitialState extends CartState {}

class LoadingState extends CartState {}

class SuccessState extends CartState {
  String message;

  SuccessState({required this.message});
}

class OrderLoadingState extends CartState {}

class LoadedState extends CartState {
  List<CartModel> cart;
  int totalAmount;
  String message;

  LoadedState({
    required this.cart,
    required this.totalAmount,
    required this.message,
  });
}

class OrderLoadedState extends CartState {
  bool success;
  String message;

  OrderLoadedState({required this.message, required this.success});
}

class FailureState extends CartState {
  String errorMessage;

  FailureState({required this.errorMessage});
}
