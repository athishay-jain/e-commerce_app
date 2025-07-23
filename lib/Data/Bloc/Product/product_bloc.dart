import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Product/product_event.dart';
import 'package:ecommerce_app/Data/Bloc/Product/product_state.dart';
import 'package:ecommerce_app/Data/Model/Product/product_model.dart';
import 'package:ecommerce_app/Data/Repository/products_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepo repo;

  ProductBloc({required this.repo}) : super(ProductsInitialState()) {
    on<LoadInitialProducts>((event, emit) async {
      emit(ProductsLoadingState());
      try {
        ProductDataModel productDataModel = await repo.loadProducts();
        if (productDataModel.status) {
          emit(ProductsLoadedState(products: productDataModel.data));
        } else {
          emit(ProductsFailureState(errorMessage: productDataModel.message));
        }
      } catch (e) {
        emit(ProductsFailureState(errorMessage: "$e"));
      }
    });
  }
}
