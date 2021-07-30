import 'package:flutter/material.dart';
import 'package:left_scroll_actions/cupertinoLeftScroll.dart';
import 'package:left_scroll_actions/global/actionListener.dart';
import 'package:left_scroll_actions/leftScroll.dart';
import 'package:provider/provider.dart';
import 'package:zyl_app2/global/Global.dart';
import 'package:zyl_app2/utils/alert_utils.dart';
import 'package:zyl_app2/viewmodel/account_viewmodel.dart';

class AccountingView extends StatefulWidget {
  @override
  _AccountingViewState createState() => _AccountingViewState();
}

class _AccountingViewState extends State<AccountingView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.read<AccountViewModel>().getList.length == 0) loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("记账"),
        centerTitle: true,
        elevation: 5,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("accounting/chart");
            },
            icon: Icon(Icons.add_chart)
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),//bottom高度
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
                        child: Text( Provider.of<AccountViewModel>(context).getMonth.toString() + "月",
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
                    Expanded(child: Text(Provider.of<AccountViewModel>(context).getIncome.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0
                      ),
                    )),
                    Expanded(child: Text(Provider.of<AccountViewModel>(context).getExpenditure.toString(),
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
      body: ListView.builder(
          itemBuilder: _itemBuilder,
          itemCount: Provider.of<AccountViewModel>(context).getList == null ? 0 : Provider.of<AccountViewModel>(context).getList.length,
          shrinkWrap: true
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: _add,
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
          children: [
              Expanded(
                child: Text(
                  Provider.of<AccountViewModel>(context).getList[index]["date"],
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Text(
                "收入:" +  Provider.of<AccountViewModel>(context).getList[index]["income"].toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(width: 8,),
              Text(
                "支出:" +  Provider.of<AccountViewModel>(context).getList[index]["expenditure"].toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        Divider(height: 1,),
        Column(
          children: _childrens(Provider.of<AccountViewModel>(context).getList[index]["data"]),
        ),
      ],
    );
  }

    List<Widget> _childrens(var datas) {
      List<Widget> widgets = [];
      for(var i=0;i<datas.length;i++) {
        widgets.add(Container(height: 8));
        widgets.add(CupertinoLeftScroll(
          key: Key(datas[i]["id"].toString()),
          closeTag: LeftScrollCloseTag('TODO: your tag'),
          bounce: true,//弹性
          child: Row(
            children: [
              Icon(Icons.add),
              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(datas[i]["type"]["action"] == 0 ? "收入" : "支出"),
                    Text("类型：" + datas[i]["type"]["name"], style: TextStyle(
                      color: Colors.blueGrey
                    ),),
                    Text("描述：" + datas[i]["desc"], style: TextStyle(
                      color: Colors.grey,
                    ),),
                  ],
                ),
              ),
              Text(datas[i]["money"].toString())
            ],
          ),
          buttons: [
            LeftScrollItem(
              text: '删除',
              color: Colors.red,
              onTap: () {
                context.read<AccountViewModel>().delete(datas[i]["id"].toString());
              },
            ),
          ]));
        widgets.add(Container(height: 8,));
      }
      
      return widgets;
    }
  void loadData() async {
    context.read<AccountViewModel>().setList([]);//先清空
    context.read<AccountViewModel>().accountingHistory();//在请求
  }

    void _getMouth() async {
      List list = [];
      for(var i = 1; i < 12; i++) {
        if(i <= DateTime.now().month) list.add(i);
      }
      var res = await showMonthList(list);
        if(res != null) {
          context.read<AccountViewModel>().setMonth(res);
          loadData();
        }
    }
  void _add() {
    Navigator.of(context).pushNamed("accounting/add");
  }
}
