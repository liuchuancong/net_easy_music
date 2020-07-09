import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class HttpManager {
  //一个人工智能回答的免费API
  final String baseUrl = 'http://y.jsososo.com';
  final int connectTimeOut = 5000;
  final int receiveTimeOut = 5000;

  //单例模式
  static HttpManager _instance;
  Dio _dio;
  BaseOptions _options;

  //单例模式，只创建一次实例
  static HttpManager getInstance() {
    if (null == _instance) {
      _instance = new HttpManager();
    }
    return _instance;
  }

  initCookie() async {
    // String b =
    //     'http://ia.51.la/go1?id=20118467&rt=${DateTime.now().millisecondsSinceEpoch}&rl=1920*1080&lang=zh-CN&ct=unknow&pf=1&ins=0&vd=8&ce=1&cd=24&ds=&ing=8&ekc=&sid=${DateTime.now().millisecondsSinceEpoch}&tt=%25E7%25BD%2591%25E6%2598%2593%25E4%25BA%2591%25E9%259F%25B3%25E4%25B9%2590&kw=&cu=http%253A%252F%252F192.168.0.107%253A8080%252F%2523%252F&pu=';

    // final Response response = await _dio.get(b);
    // var dataTime = response.headers['set-cookie']
    //     [response.headers['set-cookie'].length - 1];
    // print(dataTime);
  }

  //构造函数
  HttpManager() {
    _options = new BaseOptions(
        baseUrl: baseUrl,
        //连接时间为5秒
        connectTimeout: connectTimeOut,
        //响应时间为3秒
        receiveTimeout: receiveTimeOut,
        //设置请求头
        headers: {
          "Cookie":
              "__tins__20118467=%7B%22sid%22%3A%201594308407816%2C%20%22vd%22%3A%201%2C%20%22expires%22%3A%201594310207816%7D; __51cke__=; __51laig__=1"
        },
        //默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
        contentType: Headers.formUrlEncodedContentType,
        //共有三种方式json,bytes(响应字节),stream（响应流）,plain
        responseType: ResponseType.json);
    _dio = new Dio(_options);

    //添加拦截器
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("在请求之前的拦截信息");
      return options;
    }, onResponse: (Response response) {
      print("在响应之前的拦截信息");
      return response;
    }, onError: (DioError e) {
      print("在错误之前的拦截信息");
      return e;
    }));
  }

  //get请求方法
  get(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await _dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
    } on DioError catch (e) {
      print('getHttp exception: $e');
      formatError(e);
    }
    return response;
  }

  //post请求
  post(url, {params, options, cancelToken}) async {
    Response response;
    try {
      response = await _dio.post(url,
          queryParameters: params, options: options, cancelToken: cancelToken);
      print('postHttp response: $response');
    } on DioError catch (e) {
      print('postHttp exception: $e');
      formatError(e);
    }
    return response;
  }

  //post Form请求
  postForm(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await _dio.post(url,
          options: options, cancelToken: cancelToken, data: data);
      print('postHttp response: $response');
    } on DioError catch (e) {
      print('postHttp exception: $e');
      formatError(e);
    }
    return response;
  }

  //下载文件
  downLoadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await _dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        print('$count $total');
      });
      print('downLoadFile response: $response');
    } on DioError catch (e) {
      print('downLoadFile exception: $e');
      formatError(e);
    }
    return response;
  }

  //取消请求
  cancleRequests(CancelToken token) {
    token.cancel("cancelled");
  }

  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      print("请求取消");
    } else {
      print("未知错误");
    }
  }
}
