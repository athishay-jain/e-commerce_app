import 'package:ecommerce_app/Data/Helper/api_helper.dart';
import 'package:ecommerce_app/Data/Model/Product/Order_model.dart';
import 'package:ecommerce_app/Utilities/Data/app_url.dart';

class OrderRepo{
  ApiHelper apiHelper;
  OrderRepo({required this.apiHelper});
  Future<OrderResponseDataModel>getOrder()async{
    try{
      dynamic res = await apiHelper.getApi(url: AppUrls.getOrder);
      return OrderResponseDataModel.fromJson(res);
    }catch(e){rethrow;}
  }
}