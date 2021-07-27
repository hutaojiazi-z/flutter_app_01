import 'package:flutter/material.dart';
import 'package:zyl_app2/global/Global.dart';

class AccountingView extends StatefulWidget {
  @override
  _AccountingViewState createState() => _AccountingViewState();
}

class _AccountingViewState extends State<AccountingView> {
  List _data;
  double _expenditure = 0;
  double _income = 0;
  int _mouth;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("记账"),
        centerTitle: true,
        elevation: 5,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text(DateTime.now().year.toString() + "年",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0
                      ),
                    )),
                    Expanded(child: Text("剩余预算",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                      ),
                    )),
                    Expanded(child: Text("收入",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                      ),
                    )),
                    Expanded(child: Text("支出",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                      ),
                    )),
                  ],
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Text( _mouth.toString() + "月",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0
                          ),
                        ),
                        onTap: _getMouth,
                      ),
                    ),
                    Expanded(child: Text("1233",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),
                    )),
                    Expanded(child: Text(_income.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),
                    )),
                    Expanded(child: Text(_expenditure.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),
                    )),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [

            //在Flutter开发中遇到：Vertical viewport was given unbounded height
            //我们只需要在ListView.builder加入shrinkWrap: true,
            ListView.builder(
              itemBuilder: _itemBuilder,
              itemCount: _data == null ? 0 : _data.length,
              shrinkWrap: true
            )
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(8), child: Row(
          children: [
            Expanded(
              child: Text(
                _data[index]["date"],
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Text(
              "收入:" +  _data[index]["income"].toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(width: 8,),
            Text(
              "支出:" +  _data[index]["expenditure"].toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),),
        Divider(height: 1,),
        Column(
          children: _childrens(_data[index]["data"]),
        ),
      ],
    );
    // print(_data[index]);
    //     // return ListTile(
    //     //   title: Text(_data[index]["date"]),
    //     // );
  }

    List<Widget> _childrens(var datas) {
      List<Widget> widgets = [];
      for(var i=0;i<datas.length;i++) {
        widgets.add(Row(
          children: [
            Icon(Icons.add),
            SizedBox(width: 16,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(datas[i]["type"]["action"] == 0 ? "收入" : "支出"),
                  Text("描述：" + datas[i]["type"]["name"], style: TextStyle(
                    color: Colors.grey,
                  ),),
                ],
              ),
            ),
            Text(datas[i]["money"].toString())
          ],
        ));
        widgets.add(Container(height: 8,));
      }
      
      return widgets;
    }
  void loadData() async {
    // Global.getInstance().context = context;
    if(_mouth == null) {
      _mouth = DateTime.now().month;
    }
    print(_mouth);
    var res = await Global.getInstance().dio.get(
        "/zxw/AccountingHistory",
        queryParameters: {
          "date": DateTime.now().year.toString() + (_mouth < 10 ?
          "0" + _mouth.toString(): _mouth.toString()),
        }
    );
    setState(() {
      if(res.data["success"]) {
        _expenditure = res.data["data"]["expenditure"];
        _income = res.data["data"]["income"];
        _data = res.data["data"]["data"];
      }else {
        _expenditure = 0;
        _income = 0;
        _data = [];
        // EasyLoading.showError(res.data["msg"]);
      }
    });
  }

    void _getMouth() {
      List list = [];
      for(var i = 1; i < 12; i++) {
        if(i <= DateTime.now().month) list.add(i);
      }
      showDialog(context: context, builder: (context) {
        return SimpleDialog(
          // title: Text("选择月份"),
            children: list.map((e) {
              return SimpleDialogOption(
                child: Text(e.toString()),
                onPressed: () {
                  _mouth = e;
                  Navigator.pop(context);
                  loadData();
                },
              );
            }).toList()
        );
      },
      barrierDismissible: false,//设置选中空白处关闭
      );
    }
}
