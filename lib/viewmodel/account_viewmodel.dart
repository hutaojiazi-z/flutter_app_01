import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zyl_app2/model/account_model.dart';

class AccountViewModel extends ChangeNotifier {
  List _list = [];
  int _month;

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

  void getAccountHistory() async {
    Response result = await getAccount(_month.toString());
    print(result);
  }
}