import 'package:ecommerce_app/Data/Helper/api_helper.dart';
import 'package:ecommerce_app/Data/Model/Product/categories_model.dart';
import 'package:ecommerce_app/Data/Model/Product/category_product_model.dart';
import 'package:ecommerce_app/Utilities/Data/app_url.dart';

class CategoriesRepo {
  ApiHelper apiHelper;

  CategoriesRepo({required this.apiHelper});

  Future<CategoriesDataModel> loadCategories() async{
    try {
      dynamic res = await apiHelper.getApi(url: AppUrls.getCategories);
      return CategoriesDataModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
  Future<CategoryProductDataModel>loadCategoryProducts({required String id})async{
    try {
      dynamic res = await apiHelper.postApi(url: AppUrls.getProduct,body: {
        "category_id":id,
      });
      print(res);
      return CategoryProductDataModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
