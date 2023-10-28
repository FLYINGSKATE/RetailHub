import 'dart:developer';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../app/app.locator.dart';
import '../constants/route_names.dart';
import '../ui/methods/basecommon_methods.dart';
import 'localstorage_service.dart';
import 'navigation_service.dart';

class ApiServices {
  static int successStatusCode = 200;
  static int successStatusCodeMatterMost = 201;
  static int badRequest = 400;
  static int notFound = 404;

  static Dio dio = Dio();
  static NavigationService navigationService = locator<NavigationService>();
  static LocalStorageService localStorageService =
      locator<LocalStorageService>();

  static Future init() async {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) {
      return status! < 500;
    };

    dio.options.connectTimeout = 20000; //5s
    dio.options.receiveTimeout = 200000;
    return;
  }

  static Future<void> postRequestwithAuthToken(
      {String? url,
      String? authToken,
      Function? onError,
      Function? onSuccess,
      Map<String, dynamic>? params}) async {
    //  Fimber.i('API URL ==> $url');
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer ${authToken!}';
    if (kDebugMode) {
      print("token----" + authToken);
    }
    try {
      print("url $url");
      print("params $params");
      var response = await dio.post(
        url!,
        data: params,
      );
      onSuccess!(response.data);
    } catch (e) {
      print('error ==> $e');

      if (e is DioError) {
        print('error ==> ${e.response}');
        onError!(e.response!.statusCode.toString(), true);
      } else {
        onError!(e.toString(), false);
        print('error ==> $e');
      }
    }
    return;
  }

  static Future<void> postRequest({
    String? url,
    Map<String, dynamic>? params,
    Function? onError,
    Function? onSuccess,
  }) async {
    dio.options.headers['Content-Type'] = 'application/json';
    try {
      log(url!);
      log(params.toString());

      var response = await dio.post(url, data: params);
      try {
        onSuccess!(response.data);
      } catch (e) {
        onError!("Incorrect", true);
      }
    } on DioError catch (e) {
      onError!(e.message, true);
      log("dio error ${e.message}");
    }
    return;
  }

  static Future<void> getRequest(
      {String? url,
      String? authToken,
      Function? onError,
      Function? onSuccess,
      Map<String, dynamic>? params}) async {
    dio.options.headers['Content-Type'] = 'application/json';

    try {
      log('url is ==> $url');
      var response = await dio.get(
        url!,
        options: Options(
          method: 'GET',
          responseType: ResponseType.plain,
        ),
      );
      if (kDebugMode) {
        // log('response ==> $response');
      }
      onSuccess!(response.data);
    } catch (e) {
      if (e is DioError) {
        if(e.response!.statusCode.toString()!="500"){
          navigationService.popAllAndNavigateTo(loginViewRoute);
        }
        onError!(e.response!.statusCode.toString(), true);
      } else {
        // navigationService.popAllAndNavigateTo(loginViewRoute);
        onError!(e.toString(), false);
        if (kDebugMode) {
          print('error ==> $e');
        }
      }
    }
    return;
  }

  static Future<void> putRequestwithAuthToken(
      {String? url,
      String? authToken,
      Function? onError,
      Function? onSuccess,
      Map<String, dynamic>? params}) async {
    //  Fimber.i('API URL ==> $url');
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer ${authToken!}';

    try {
      print("url $url");
      print("params $params");
      var response = await dio.put(
        url!,
        data: params,
      );
      onSuccess!(response.data);
    } catch (e) {
      print('error ==> $e');

      if (e is DioError) {
        print('error ==> ${e.response}');
        onError!(e.response!.statusCode.toString(), true);
      } else {
        onError!(e.toString(), false);
        print('error ==> $e');
      }
    }
    return;
  }
}
