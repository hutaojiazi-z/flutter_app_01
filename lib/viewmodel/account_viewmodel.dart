import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zyl_app2/model/account_model.dart';

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
    Response result = await getAccount(_month.toString());
    print(result);
  }
}