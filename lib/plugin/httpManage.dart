import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:net_easy_music/utils/cookie.dart';

import 'flutterToastManage.dart';

class HttpManager {
  //一个人工智能回答的免费API
  final String baseUrl = 'http://y.jsososo.com';
  final int connectTimeOut = 10000;
  final int receiveTimeOut = 10000;

  //单例模式
  static HttpManager _instance;
  Dio _dio;
  BaseOptions _options;
  BuildContext _context;
  HttpManager._internal(BuildContext context) {
    this._context = context;
  }
  //单例模式，只创建一次实例
  static HttpManager getInstance(BuildContext context) {
    _instance = HttpManager._internal(context);
    return _instance;
  }

  initCookies(RequestOptions options) {
    int nowTime = DateTime.now().millisecondsSinceEpoch;
    if (cookieMange.expiresTime < nowTime) {
      cookieMange.cookieInitTime = nowTime;
    }
    Map<String, dynamic> headers = new Map();
    headers['Content-Type'] = 'application/json;charset=utf-8';
    headers['User-Agent'] =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36';
    headers['Cookie'] =
        '__51cke__=; __tins__20118467={"sid": ${cookieMange.cookieInitTime}, "vd": 1, "expires": ${cookieMange.expiresTime}}; __51laig__=10';
    options.headers.addAll(new Map<String, dynamic>.from(headers));
  }

  //构造函数
  HttpManager(context) {
    _options = new BaseOptions(
        baseUrl: baseUrl,
        //连接时间为5秒
        connectTimeout: connectTimeOut,
        //响应时间为3秒
        receiveTimeout: receiveTimeOut,
        //设置请求头
        headers: {},
        //默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
        //共有三种方式json,bytes(响应字节),stream（响应流）,plain
        responseType: ResponseType.json,
        contentType:
            ContentType.parse("application/json;charset=utf-8").toString());
    _dio = new Dio(_options);

    //添加拦截器
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      this.initCookies(options);
      return options;
    }, onResponse: (Response response) {
      print("在响应之前的拦截信息");
      return response;
    }, onError: (DioError e) {
      print("在错误之前的拦截信息");
      return e;
    }));
    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.findProxy = (url) {
    //     return "PROXY 192.168.2.114:8888";
    //   };
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    // };
    this._context = context;
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
  post(url, {params, options, cancelToken, data}) async {
    Response response;
    try {
      response = await _dio.post(url,
          queryParameters: params,
          options: options,
          cancelToken: cancelToken,
          data: data);
    } on DioError catch (e) {
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
    } on DioError catch (e) {
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
      FlutterToastManage().showToast("连接超时", this._context);
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      FlutterToastManage().showToast("请求超时", this._context);
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      FlutterToastManage().showToast("响应超时", this._context);
    } else if (e.type == DioErrorType.RESPONSE) {
      FlutterToastManage().showToast("出现异常", this._context);
    } else if (e.type == DioErrorType.CANCEL) {
      FlutterToastManage().showToast("请求取消", this._context);
    } else {
      FlutterToastManage().showToast("未知错误", this._context);
    }
  }
}
