import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zyl_app2/model/account_model.dart';
import 'package:zyl_app2/utils/event_utils.dart';


class AccountViewModel extends ChangeNotifier {
  List _list = [];
  int _month;
  double _expenditure = 0; //支出
  double _income = 0; //收入

  List get getList {
    return _list;
  }

  void setList(List list) {
    _list = list;
    notifyListeners();
  }

  int get getMonth {
    if (_month == null) {
      _month = DateTime.now().month;
    }
    return _month;
  }

  void setMonth(int month) {
    _month = month;
    notifyListeners();
  }

  double get getExpenditure {
    return _expenditure;
  }

  void setExpenditure(double val) {
    _expenditure = val;
    notifyListeners();
  }

  double get getIncome {
    return _income;
  }

  void setIncome(double val) {
    _income = val;
    notifyListeners();
  }

  void accountingHistory() async {
    Response result = await getAccount(
      DateTime.now().year.toString() +
          (getMonth < 10 ? "0" + getMonth.toString() : getMonth.toString())
    );
    print(result);
    if (result.data["success"]) {
      setList(result.data["data"]["data"]);
      setExpenditure(result.data["data"]["expenditure"]);
      setIncome(result.data["data"]["income"]);
    } else {
      postMessage("fail", result.data["msg"]);
    }
  }

  void delete(String id) async {
    Response result = await deleteAccount(id);
    print(result);
    if (result.data["success"]) {
      await accountingHistory();
    } else {
      postMessage("fail", result.data["msg"]);
    }
  }
}