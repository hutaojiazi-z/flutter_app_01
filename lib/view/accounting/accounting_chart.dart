import 'package:flutter/material.dart';
import 'package:flutter_chart_csx/chart/bean/chart_bean_pie.dart';
import 'package:flutter_chart_csx/chart/enum/chart_pie_enum.dart';
import 'package:flutter_chart_csx/chart/view/chart_pie.dart';
import 'package:zyl_app2/base/view.dart';

class AccountingChartView extends StatefulWidget {
  @override
  _AccountingChartViewState createState() => _AccountingChartViewState();
}

class _AccountingChartViewState extends State<AccountingChartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar("图形报表"),
      body: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        color: Colors.orangeAccent.withOpacity(0.6),
        clipBehavior: Clip.antiAlias,
        borderOnForeground: true,
        child: ChartPie(
          chartBeans: [
            ChartPieBean(
                type: '话费',
                value: 180,
                color: Colors.blueGrey,
                assistTextStyle: TextStyle(fontSize: 12, color: Colors.blueGrey)),
            ChartPieBean(
                type: '零食',
                value: 40,
                color: Colors.deepPurple,
                assistTextStyle: TextStyle(fontSize: 12, color: Colors.deepPurple)),
            ChartPieBean(
                type: '衣服',
                value: 100,
                color: Colors.green,
                assistTextStyle: TextStyle(fontSize: 12, color: Colors.green))
          ],
          //辅助性文案显示的样式
          assistTextShowType: AssistTextShowType.OnlyName,
          //开始画圆的位置（枚举）
          arrowBegainLocation: ArrowBegainLocation.Right,
          backgroundColor: Colors.white,
          assistBGColor: Color(0xFFF6F6F6),
          //辅助性百分比显示的小数位数,（饼状图还是真实的比例）
          decimalDigits: 1,
          //各个占比之间的分割线宽度，默认为0即不显示分割
          divisionWidth: 0.1,
          size: Size(
              MediaQuery.of(context).size.width, MediaQuery.of(context).size.width),
          // 圆盘的半径，设置太长会按照可承受（除去basebean的basepadding的限制之后）最小的宽或者高的长度的一半
          globalR: MediaQuery.of(context).size.width / 3,
          //中心的圆半径
          centerR: 2,
          centerColor: Colors.white,
          centerWidget: Text(
            '',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
