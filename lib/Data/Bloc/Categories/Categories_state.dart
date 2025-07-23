import 'package:ecommerce_app/Data/Model/Product/categories_model.dart';
import 'package:ecommerce_app/Data/Model/Product/category_product_model.dart';

abstract class CategoriesState {}

class InitialState extends CategoriesState {}

class LoadingState extends CategoriesState {}

class LoadedState extends CategoriesState {
  List<CategoriesModel> categories;

  LoadedState({required this.categories});
}

class FailureState extends CategoriesState {
  String errorMessage;

  FailureState({required this.errorMessage});
}
