import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Global {
  static Global _instance;
  Dio dio;
  String token;
  Map user;
  static Global getInstance() {
    // ignore: unnecessary_null_comparison
    if(_instance == null) _instance = new Global();
    return _instance;
  }

  Global() {
    dio = new Dio();
    dio.options = BaseOptions(
      baseUrl: "https://zxw.td0f7.cn/",
      connectTimeout: 5000,//链接超时
      sendTimeout: 5000,//发送超时
      receiveTimeout: 5000,//回调超时
      // headers: {
      //   "token": "5757575"//检测登录
      // },
      contentType: Headers.formUrlEncodedContentType,//请求数据类型
      responseType: ResponseType.json, //回调数据类型
    );
    //拦截监听
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {//请求
        EasyLoading.show(status: "Loading...");
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {//返回
        EasyLoading.dismiss();
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {//错误
        print(e.toString());
        EasyLoading.dismiss();
        String msg = "";
        if (e.type == DioErrorType.connectTimeout) {
          msg = "连接超时错误";
        } else {
          msg = "接口错误！";
        }
        EasyLoading.showError(msg);
      },
    ));
  }
}