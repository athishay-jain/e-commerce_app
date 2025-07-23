import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/Data/Bloc/Categories/Categories_event.dart';
import 'package:ecommerce_app/Data/Bloc/Categories/Categories_state.dart';
import 'package:ecommerce_app/Data/Model/Product/categories_model.dart';
import 'package:ecommerce_app/Data/Model/Product/category_product_model.dart';
import 'package:ecommerce_app/Data/Repository/categories_repo.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesRepo repo;

  CategoriesBloc({required this.repo}) : super(InitialState()) {
    on<LoadCategoriesEvent>((event, emit) async {
      emit(LoadingState());
      try {
        CategoriesDataModel dataModel = await repo.loadCategories();
        print(dataModel.status.toString());
        if (dataModel.status) {
          print("testing");
          emit(LoadedState(categories: dataModel.data));
        } else {
          emit(FailureState(errorMessage: dataModel.message));
        }
      } catch (e) {
        emit(FailureState(errorMessage: e.toString()));
      }
    });

  }
}
