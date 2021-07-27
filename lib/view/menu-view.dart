import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zyl_app2/base/view.dart';
import 'package:zyl_app2/global/Global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zyl_app2/global/global_theme.dart';
import 'package:provider/provider.dart';
import 'package:zyl_app2/viewmodel/theme_viewmodel.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuViewState createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbarAction("菜单", [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            Navigator.of(context).pushNamed('theme');
          }
        )
      ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(Global.getInstance().user["name"].toString()),
              accountEmail: Text(Global.getInstance().user["phone"].toString()),
              otherAccountsPictures: [
                Image.asset('images/cat.jpg')
              ],
              currentAccountPicture: ClipOval(//圆形头像
                child: Image.asset('images/girl.jpg'),
              )

            ),
            ListTile(
              title: Text("支出上限"),
              subtitle: Text(Global.getInstance().user["money"].toString()),
              trailing: Icon(Icons.navigate_next),
              onTap: () {},
            ),
            Divider(height: 1,),
            ListTile(
              title: Text("注册日期"),
              subtitle: Text(Global.getInstance().user["date"].toString()),
            ),
            Divider(height: 1,),
            ListTile(
              title: Text("退出登录"),
              trailing: Icon(Icons.exit_to_app),
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.remove('token');
                Navigator.of(context).popAndPushNamed("/");
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return new Image.asset("images/girl.jpg", fit: BoxFit.cover,);
              },
              itemCount: 3,
              pagination: SwiperPagination(),
              control: SwiperControl(),
            ),
          ),
          SizedBox(height: 16.0.h,),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed("accounting");
            },
            child: Text("记账"),
          ),
        ],
      )
    );
  }
}
