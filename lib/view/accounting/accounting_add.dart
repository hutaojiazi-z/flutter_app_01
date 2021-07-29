import 'package:flutter/material.dart';
import 'package:zyl_app2/base/view.dart';
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _money.dispose();
    _desc.dispose();
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
              trailing: Text("data"),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text("方式"),
              trailing: Text("data"),
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

  void _submit() {
    print("嫌憎");
  }
}
