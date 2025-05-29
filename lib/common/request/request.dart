import 'dart:convert';
import 'package:dio/dio.dart';

class RequestData<T> {
  final T data;
  final int status;
  final String statusText;

  RequestData({
    required this.data,
    required this.status,
    required this.statusText,
  });
}

class Request {
  static String _httpsUrl = 'https://xxx.com';
  static String _appVersion = '/2_0_0/';

  static Dio anotherDio = Dio(BaseOptions(
    baseUrl: _httpsUrl,
    // method: 'GET',
    receiveTimeout: const Duration(seconds: 10),
    connectTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      "version": _appVersion,
    },
  ));

  /// get请求
  static Future<RequestData<T>> get<T>({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    Future<RequestData<T>> future;
    try {
      Response<String> responseStr = await anotherDio.get(url, data: data);
      RequestData<T>? res = _handleRequest<T>(responseStr.data ?? '');
      if (res != null) {
        future = Future.value(res);
      } else {
        future = Future.error("服务器连接异常！");
      }
    } on DioException catch (error) {
      /// 请求错误处理
      print('请求url：$url，请求异常: $error');
      future = Future.error("服务器连接异常！$error");
    }
    return future;
  }

  /// post请求
  static Future<RequestData<T>> post<T>({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    Future<RequestData<T>> future;
    try {
      Response<String> responseStr = await anotherDio.post(url, data: data);
      RequestData<T>? res = _handleRequest<T>(responseStr.data ?? '');
      if (res != null) {
        future = Future.value(res);
      } else {
        future = Future.error("服务器连接异常！");
      }
    } on DioException catch (error) {
      /// 请求错误处理
      print('请求url：$url，请求异常: $error');
      future = Future.error("服务器连接异常！$error");
    }
    return future;
  }

  static RequestData<T>? _handleRequest<T>(String responseJson) {
    if (responseJson != '') {
      try {
        Map<String, dynamic> jsonData = json.decode(responseJson); // 转换json
        // print('请求url：$url，请求参数JSON: $data');
        // // print('请求url：$url，请求参数: $cryptoJSJson');
        // print('请求url：$url，请求结果json: $jsonData');
        return RequestData<T>(
          data: jsonData['data'],
          status: jsonData['status'],
          statusText: jsonData['info'],
        );
      } catch (error) {
        print("request json error = $error");
      }
    }
    return null;
  }
}
