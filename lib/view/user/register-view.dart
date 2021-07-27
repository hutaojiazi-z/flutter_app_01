import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zyl_app2/base/view.dart';
import 'package:zyl_app2/utils/date_utils.dart';
import 'package:zyl_app2/viewmodel/register_viewmodel.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  TextEditingController _user;
  TextEditingController _pass;
  TextEditingController _phone;
  TextEditingController _code;
  TextEditingController _name;
  DateTime _dateTime;
  int _gender = 0;//0:男,女:1
  int _solar = 0; //0:阳历,1:阴历
  int _count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = TextEditingController();
    _pass = TextEditingController();
    _phone = TextEditingController();
    _code = TextEditingController();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _user.dispose();
    _pass.dispose();
    _phone.dispose();
    _code.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar('注册'),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(//账号输入框
              decoration: InputDecoration(
                  labelText: "登录账号",
                  hintText: "请输入账号"
              ),
              // controller: Provider.of<LoginViewModel>(context).getUser,
              controller: _user,
              autofocus: true,
              textInputAction: TextInputAction.next,
            ),
            Stack(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: "手机号码",
                      hintText: "请输入手机号码"
                  ),
                  // controller: Provider.of<LoginViewModel>(context).getUser,
                  controller: _phone,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                ),
                Positioned(
                  right: 10,
                  bottom: 0,
                  child: ElevatedButton(
                    child: Text(_count > 0 ? "${_count}s后重新获取" : "获取验证码"),
                    onPressed: _count > 0 ? null : _getCode,
                  ),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "验证码",
                  hintText: "请输入获取到的验证码"
              ),
              // controller: Provider.of<LoginViewModel>(context).getUser,
              controller: _code,
              autofocus: true,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "登陆密码",
                hintText: "请输入登陆密码",
              ),
              controller: _pass,
              textInputAction: TextInputAction.next,
              obscureText: true,
            ),
            Stack(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: "中文姓名",
                    hintText: "请输入中文姓名",
                  ),
                  controller: _name,
                  textInputAction: TextInputAction.next,
                ),
                Positioned(//定位
                  right: 10,
                  child: Row(
                    children: [
                      Switch(
                        value: _gender == 0 ? false : true,
                        onChanged: (v) {
                          setState(() {
                            _gender = v ? 1 : 0;
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      Text(
                        _gender == 0 ? "男" : "女",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(_dateTime != null ? getYMD(_dateTime):'请选择日期')
                        // Text(_dateTime != null ? getYMD(_dateTime) : "请选择日期"),
                      ],
                    ),
                  ),
                  onTap: _alertDateTime,
                ),
                Positioned(
                  right: 10,
                  child: Row(
                    children: [
                      Switch(
                        value: _solar == 0 ? false : true,
                        onChanged: (v) {
                          setState(() {
                            _solar = v ? 1 : 0;
                          });
                        },
                      ),
                      SizedBox(width: 8),
                      Text(
                        _solar == 0 ? "阳历" : "阴历",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Container(
                height: 50,
                child: ElevatedButton(
                  child: Text("注册"),
                  // color: Colors.redAccent,
                  onPressed: _register,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _alertDateTime() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now())
      .then((value) {
        setState(() {
          _dateTime = value;
        });
      }).catchError((e) {
        print(e);
      }
    );
  }

  void _getCode() {
    setState(() {
      _count = 60;
    });
    _task();
  }

  void _task() {
    Future.delayed(new Duration(seconds: 1), () {
      setState(() {
        _count--;
        if(_count > 0) {
          _task();
        }
      });
    });
  }

  void _register() {
    if (_user.text == null || _user.text.isEmpty) {
      EasyLoading.showError("账号不能为空！");
      return;
    } else if (_pass.text == null || _pass.text.isEmpty) {
      EasyLoading.showError("密码不能为空！");
      return;
    } else if (_name.text == null || _name.text.isEmpty) {
      EasyLoading.showError("姓名不能为空！");
      return;
    } else if (_phone.text == null || _phone.text.isEmpty) {
      EasyLoading.showError("手机号不能为空！");
      return;
    } else if (_code.text == null || _code.text.isEmpty) {
      EasyLoading.showError("验证码不能为空！");
      return;
    } else if (_dateTime == null) {
      EasyLoading.showError("生日不能为空！");
      return;
    }
  print("//////////////");
    context.read<RegisterViewModel>().register(
      _user.text,
      _pass.text,
      _name.text,
      _phone.text,
      _code.text,
      _gender,
      getYMD(_dateTime),
      _solar,
    );
  }
}
