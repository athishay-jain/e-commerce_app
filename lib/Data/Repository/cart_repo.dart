import 'package:ecommerce_app/Data/Helper/api_helper.dart';
import 'package:ecommerce_app/Data/Model/Product/cart_model.dart';
import 'package:ecommerce_app/Utilities/Data/app_url.dart';

class CartRepo {
  ApiHelper apiHelper;
  CartRepo({required this.apiHelper});
  Future<dynamic>AddToCart({required int productId,required int qty})async{
    try{
      return await apiHelper.postApi(url: AppUrls.addToCart,body: {
        "product_id":productId,
        "quantity":qty,
      });
    }catch(e){rethrow;}
  }
  Future<CartDataModel> getCart()async{
    try{
     dynamic res= await apiHelper.getApi(url: AppUrls.getCart);
     return CartDataModel.fromMap(res);
    }catch(e){rethrow;}
  }
  Future<dynamic>deleteItem({required int cart_id})async{
    try{
      return await apiHelper.postApi(url: AppUrls.deleteItem,body: {
        "cart_id":cart_id
      });
    }catch(e){rethrow;}
  }
  Future<dynamic>decrementItem({required int product_id,required int qty})async{
    try{
      print("the Url for the decrement_quantity is${AppUrls.decrement}");
      return await apiHelper.postApi(url: AppUrls.decrement,body: {
        "product_id":product_id,
        "quantity":qty,
      });
    }catch(e){rethrow;}
  }
  Future<dynamic>placeOrder({required int cart_id})async{
    try{
      return await apiHelper.postApi(url: AppUrls.placeOrder,body: {
        "cart_id":cart_id
      });
    }catch(e){rethrow;}
  }

}
