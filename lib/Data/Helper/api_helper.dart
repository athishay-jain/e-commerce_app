import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_app/Data/Helper/app_exceptions.dart';
import 'package:ecommerce_app/Utilities/Data/app_constants.dart';
import 'package:ecommerce_app/Utilities/Data/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  Future<dynamic> getApi({Map<String, String>? header,required String url,}) async {
    header = header ?? {};
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString(AppConstants.userToken) ?? "";
    header["Authorization"] = "Bearer $token";
    try {
      http.Response res = await http.get(
        Uri.parse(url),
        headers: header,
      );
     return handelResponse(res);
    } on SocketException {
      throw (NetworkException(message: "No Internet Connection"));
    } catch (e) {
      throw (ServerException(message: "Server error:$e"));
    }
  }

  Future<dynamic> postApi({
    required String url,
    Map<String, dynamic>? body,
    Map<String, String>? header,
    bool isAuth = false,
  }) async {
    if (!isAuth) {
      header ??= {};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(AppConstants.userToken) ?? "";
      header["Authorization"] = "Bearer $token";
    }
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: header,
      );
      return handelResponse(response);
    } on SocketException {
      throw (NetworkException(message: "No Internet Connection"));
    } catch (e) {
      throw (ServerException(message: "Server error:$e"));
    }
  }

  dynamic handelResponse(http.Response res) {
    switch (res.statusCode) {
      case 200:
        return jsonDecode(res.body);
      case 400:
        throw (InvalidInputException(message: "Bad Request"));
      case 401:
        throw (UnauthorizedException(message: "Unauthorized Access"));
      case 404:
        throw (NetworkException(message: "Not Connected"));
      case 500:
        throw (ServerException(message: "Internal Server Error"));
      default:
        throw (ServerException(message: "Unknown Error:${res.statusCode}"));
    }
  }
}
