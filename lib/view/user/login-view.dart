
import 'package:flutter/material.dart';
import 'package:zyl_app2/base/view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zyl_app2/global/Global.dart';
import 'package:zyl_app2/viewmodel/login_viewmodel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  TextEditingController _user;
  TextEditingController _pass;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = new TextEditingController();
    _pass = new TextEditingController();
    loadData();
  }

  @override
  void dispose() {//注销
    // TODO: implement dispose
    super.dispose();
    _user.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar('登录'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image.asset(
                "images/cat.jpg",
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              TextField(//账号输入框
                style: TextStyle(
                  fontSize: 14.sp
                ),
                decoration: InputDecoration(
                    labelText: "账号",
                    hintText: "请输入账号",
                    prefixIcon: Icon(Icons.person)
                ),
                // controller: Provider.of<LoginViewModel>(context).getUser,
                controller: _user,
                autofocus: true,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 16.h),
              TextField(
                style: TextStyle(
                    fontSize: 14.sp
                ),
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText : "请输入密码",
                  prefixIcon: Icon(Icons.lock),
                ),
                // controller: Provider.of<LoginViewModel>(context).getPass,
                controller: _pass,
                textInputAction: TextInputAction.send,
                onSubmitted: (String str) {
                  print("submit");
                },
              ),
              SizedBox(height: 16),
              GestureDetector(//GestureRecognizer, 添加的点击事件
                child: Container(
                  width: double.infinity,//最大宽度 100%
                  child: Text(
                    "找回密码",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                    textAlign: TextAlign.right,

                  ),
                ),
                onTap: () {
                  print("找回密码");
                },
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Text("登录", style: TextStyle(
                        fontSize: 14.sp),
                    ),
                  ),
                  // color: Theme.of(context).accentColor,//获取主题色
                  onPressed: _login,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.h),
                    child: Text("注册", style: TextStyle(
                        fontSize: 14.sp),
                    ),
                  ),
                  onPressed: _register,
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  void loadData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = await sp.getString("token");
    print(token);
    if (token != null) {
      Global.getInstance().dio.options.headers["token"] = token;
      context.read<LoginViewModel>().tokenLogin();
    }
  }

  void _login() {
    if(_user.text == null && _user.text.isEmpty) {
      EasyLoading.showError("请输入账号");
    } else if(_pass.text == null && _pass.text.isEmpty) {
      EasyLoading.showError("请输入密码");
    }
    context.read<LoginViewModel>().login(_user.text, _pass.text);

  }
  void _register() async {
    dynamic params = await Navigator.of(context).pushNamed("register");
    print(params);
    if(params != null) {
      setState(() {
        _user.text = params["user"];
        _pass.text = params["pass"];
      });
    }
  }
}
