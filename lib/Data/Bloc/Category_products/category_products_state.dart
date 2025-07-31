import '../../Model/Product/product_model.dart';

abstract class CategoryProductsState {}

class InitialState extends CategoryProductsState {}

class LoadingState extends CategoryProductsState {}

class LoadedState extends CategoryProductsState {
  List<ProductModel> products;

  LoadedState({required this.products});
}

class FailureState extends CategoryProductsState {
  String errorMessage;

  FailureState({required this.errorMessage});
}
