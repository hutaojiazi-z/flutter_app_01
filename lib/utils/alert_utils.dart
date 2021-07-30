import 'package:flutter/material.dart';
import 'package:zyl_app2/main.dart';

Future showMonthList(List list) async {

  return await showDialog(
    context: navigatorKey.currentContext,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text("选择统计月份:"),
        children: list.map((e) {
          return SimpleDialogOption(
            child: Text(e.toString()),
            onPressed: () {
              Navigator.pop(context, e);//关闭弹框

            },
          );
        }).toList()
      );
    },
    barrierDismissible: false,//设置选中空白处关闭
  );
}

Future showObjectAlertDialog(List list, String title, String content) async {

  return await showDialog(
    context: navigatorKey.currentContext,
    builder: (BuildContext context) {
      return SimpleDialog(
          title: Text(title),
          children: list.asMap().keys.map((e) {
            return SimpleDialogOption(
              child: Text(list[e][content]),
              onPressed: () {
                Navigator.pop(context, e);//关闭弹框
              },
            );
          }).toList()
      );
    },
    barrierDismissible: true,//设置选中空白处关闭
  );
}