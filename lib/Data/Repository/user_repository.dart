import 'package:ecommerce_app/Data/Helper/api_helper.dart';
import 'package:ecommerce_app/Data/Model/users/profile_model.dart';
import 'package:ecommerce_app/Utilities/Data/app_constants.dart';
import 'package:ecommerce_app/Utilities/Data/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/users/user_model.dart';

class UserRepository {
  ApiHelper apiHelper;

  UserRepository({required this.apiHelper});

  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      print("email:$email, and paswword is :$password");
      dynamic res = await apiHelper.postApi(
        url: AppUrls.login,
        isAuth: true,
        body: {"email": email, "password": password},
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signUpUser({required UserModel newUser}) async {
    try {
      dynamic res = apiHelper.postApi(
        url: AppUrls.signUp,
        isAuth: true,
        body: newUser.toMap(),
      );
      return res;
    } catch (e) {
      rethrow;
    }
  }
  Future<ProfileDataResponse>getProfile()async{
    try{
      dynamic res = await apiHelper.postApi(url: AppUrls.getProfile);
      return ProfileDataResponse.fromJson(res);
    }catch(e){rethrow;}
  }
}
