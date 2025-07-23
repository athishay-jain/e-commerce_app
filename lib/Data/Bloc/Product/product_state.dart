import 'package:ecommerce_app/Data/Model/Product/product_model.dart';

abstract class ProductState {}

class ProductsInitialState extends ProductState {}

class ProductsLoadingState extends ProductState {}

class ProductsLoadedState extends ProductState {
  List<ProductModel> products;

  ProductsLoadedState({required this.products});
}

class ProductsFailureState extends ProductState {
  String errorMessage;

  ProductsFailureState({required this.errorMessage});
}
