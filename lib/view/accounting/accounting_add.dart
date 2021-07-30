import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zyl_app2/base/view.dart';
import 'package:zyl_app2/eventbus/event_bus.dart';
import 'package:zyl_app2/global/Global.dart';
import 'package:zyl_app2/model/account_add_model.dart';
import 'package:zyl_app2/utils/alert_utils.dart';
import 'package:zyl_app2/utils/date_utils.dart';
import 'package:zyl_app2/viewmodel/account_add_viewmodel.dart';
import 'package:zyl_app2/viewmodel/account_viewmodel.dart';
class AccountingAddView extends StatefulWidget {
  @override
  _AccountingAddViewState createState() => _AccountingAddViewState();
}

class _AccountingAddViewState extends State<AccountingAddView> {

  TextEditingController _money;//文本控制器 金额
  TextEditingController _desc;//描述

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _money = TextEditingController();
    _desc = TextEditingController();
    bus.on("accounting_add_result", (arg) {
      context.read<AccountViewModel>().accountingHistory();
      setState(() {
        _money.text = "";
        _desc.text = "";
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _money.dispose();
    _desc.dispose();
    bus.off("accounting_add_result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("新增记账"),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text("类型"),
              trailing: Text(Provider.of<AccountAddViewModel>(context).getTypes[
              Provider.of<AccountAddViewModel>(context).getType
              ]["name"]),
              onTap: _showTypeAlert,
            ),
            Divider(height: 1,),
            ListTile(
              title: Text("方式"),
              trailing: Text(Provider.of<AccountAddViewModel>(context).getMode == null ? "" :
              Provider.of<AccountAddViewModel>(context).getMode["name"]),
              onTap: _accountingTypes,
            ),
            Divider(height: 1,),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入金额"
                ),
                controller: _money,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: true,
              ),
            ),
            Divider(height: 1,),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "请输入备注"
                ),
                controller: _desc,
                textInputAction: TextInputAction.send,
              ),
            ),
            Divider(height: 1,),
            SizedBox(height: 16,),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              height: 35,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: Text("新增"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showTypeAlert() async{
    var res = await showObjectAlertDialog(context.read<AccountAddViewModel>().getTypes, "选择类型", "name");
    if(res != null && res != context.read<AccountAddViewModel>().getType) {
      context.read<AccountAddViewModel>().setType(res);
      context.read<AccountAddViewModel>().setMode(null);
      context.read<AccountAddViewModel>().setModes([]);
    }
  }

  void _accountingTypes() async {
    context.read<AccountAddViewModel>().getModeAndAlert();
  }

  void _submit() async {
    context.read<AccountAddViewModel>().insert(_money.text, _desc.text);
  }
}
