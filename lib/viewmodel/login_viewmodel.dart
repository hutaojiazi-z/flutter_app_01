import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zyl_app2/global/Global.dart';
import 'package:zyl_app2/main.dart';
import 'package:zyl_app2/model/login_model.dart';

//包含所有变量和请求 全局状态管理
class LoginViewModel extends ChangeNotifier {
  void login(String user, String pass) async { //账号,密码登录
    SharedPreferences sp = await SharedPreferences.getInstance();
    Response res = await loginModel(user, pass);
    if(res.data['success']) {
      // {"success":true,"msg":null,"data":{"token":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOlsiMSIsInd6Il0sImV4cCI6MTYyODUwMzU5OSwiaWF0IjoxNjI1ODI1MTk5fQ.2CYQAhWVH9Jf1HOP4KAGL9BtpMeLc8-m03dOxA6-16A","user":{"id":1,"username":"wz","password":"","phone":"18310035782","money":5000.0,"name":"王众","gender":0,"birthday":"1996-08-13","solar":1,"love_date":"2017-04-29","vip_date":null,"love_uid":2,"date":"2021-02-21 14:38:10"}}}

      Global.getInstance().token = res.data["data"]["token"];
      Global.getInstance().user = res.data["data"]["user"];
      sp.setString("token", res.data["data"]["token"]); //添加缓存
      Global.getInstance().dio.options.headers["token"] = res.data["data"]["token"];
      Navigator.of(navigatorKey.currentContext).popAndPushNamed('menu');
    } else {
      EasyLoading.showError(res.data["msg"]);
    }
  }
  void tokenLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();//获取缓存
    Response res = await tokenLoginModel();
    if(res.data['success']) {
      Global.getInstance().user = res.data["data"];
      Navigator.of(navigatorKey.currentContext).popAndPushNamed('menu');
    }else {
      sp.remove("token");
    }
  }
}