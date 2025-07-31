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
    final decodedBody = jsonDecode(res.body);
    switch (res.statusCode) {
      case 200:
        return decodedBody ;
      case 400:
        throw (InvalidInputException(message: decodedBody['error'] ??"Bad Request"));
      case 401:
        throw (UnauthorizedException(message:decodedBody['error'] ?? "Unauthorized Access"));
      case 404:
        throw (ServerException(message: decodedBody['error'] ??"Route not found"));
      case 500:
        throw (ServerException(message: decodedBody['error'] ??"Internal Server Error"));
      default:
        throw (ServerException(message:decodedBody['error'] ?? "Unknown Error:${res.statusCode}"));
    }
  }
}
