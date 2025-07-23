import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Category_products/category_products_event.dart';
import 'package:ecommerce_app/Data/Bloc/Category_products/category_products_state.dart';
import 'package:ecommerce_app/Data/Repository/categories_repo.dart';

import '../../Model/Product/category_product_model.dart';

class CategoryProductBloc extends Bloc<CategoryProductsEvent,CategoryProductsState>{
  CategoriesRepo repo;
  CategoryProductBloc({required this.repo}):super(InitialState()){
    on<LoadProducts>((event, emit) async {
      emit(LoadingState());
      try {
        CategoryProductDataModel dataModel= await repo.loadCategoryProducts(id: event.cat_id);
        if (dataModel.status) {
          emit(LoadedState(products: dataModel.data));
        } else {
          emit(FailureState(errorMessage: dataModel.message));
        }
      } catch (e) {
        emit(FailureState(errorMessage: e.toString()));
      }
    });
  }
}