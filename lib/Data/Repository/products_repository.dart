import 'package:ecommerce_app/Data/Helper/api_helper.dart';
import 'package:ecommerce_app/Data/Model/Product/product_model.dart';
import 'package:ecommerce_app/Utilities/Data/app_url.dart';

class ProductRepo {
  ApiHelper apiHelper;

  ProductRepo({required this.apiHelper});

  Future<ProductDataModel> loadProducts() async {
    try {
      dynamic res = await apiHelper.postApi(url: AppUrls.getProduct);
      print(res);
      return ProductDataModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
