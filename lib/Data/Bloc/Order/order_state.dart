import 'package:ecommerce_app/Data/Model/Product/Order_model.dart';

abstract class OrderState {}
class InitialState extends OrderState{}
class LoadingState extends OrderState{}
class LoadedState extends OrderState{
  List<OrderResponseModel> orderData;
  LoadedState({required this.orderData});
}
class FailureState extends OrderState{
  String errorMessage;
  FailureState({required this.errorMessage});
}