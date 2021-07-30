import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:zyl_app2/eventbus/event_bus.dart';
import 'package:zyl_app2/global/Global.dart';
import 'package:zyl_app2/model/account_add_model.dart';
import 'package:zyl_app2/model/account_model.dart';
import 'package:zyl_app2/utils/alert_utils.dart';
import 'package:zyl_app2/utils/date_utils.dart';
import 'package:zyl_app2/utils/event_utils.dart';


class AccountAddViewModel extends ChangeNotifier {
  List<Map> _types = [
    { "name": "收入", "id": 0, },
    { "name": "支出", "id": 1, },
  ];

  int _type = 0;//类型选中下标
  var _mode; //选中的方式对象
  List _modes = []; //方式集合

  List get getTypes {
    return _types;
  }

  int get getType {
    return _type;
  }

  void setType(int type) {
    _type = type;
    notifyListeners();
  }

  Map get getMode {
    return _mode;
  }

  void setMode(Map mode) {
    _mode = mode;
    notifyListeners();
  }

  List get getModes {
    return _modes;
  }

  void setModes(List list) {
    _modes = list;
    notifyListeners();
  }

  void getModeAndAlert() async {
    if( getModes != null && getModes.length > 0) {
      //如果数据不等于空则直接选择
      var val = await showObjectAlertDialog(_modes, "选择方式", "name");
      if (val != null && _mode != getModes[val]) {
        setMode(getModes[val]);
      }
      return ;
    }
    var res = await getAccountingTypes(getTypes[getType]["id"]);
    setModes(res.data["data"]);

    if (res.data["success"]) {
      var val = await showObjectAlertDialog(getModes, "选择方式", "name");
      if (val != null && getMode != getModes[val]) {
        setMode(getModes[val]);
      }
    } else {
      EasyLoading.showError(res.data["msg"]);
    }
  }

  void insert(String money, String desc) async {
    Map map = {
      "t_id": getMode["id"],
      "u_id": Global.getInstance().user["id"],
      "action": _type,
      "money": money,
      "desc": desc,
      "date": getYMD(DateTime.now()),
    };
    var result = await insertAccounting(json.encode(map));

    if(result.data["success"]) {
      setMode(null);
      setType(0);
      bus.emit("accounting_add_result");
      EasyLoading.showSuccess(result.data["msg"]);
    }else {
      EasyLoading.showError(result.data["msg"]);
    }
  }

}