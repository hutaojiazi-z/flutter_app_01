import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zyl_app2/base/view.dart';
import 'package:zyl_app2/global/global_theme.dart';
import 'package:zyl_app2/viewmodel/theme_viewmodel.dart';

class SettingsTheme extends StatefulWidget {
  @override
  _SettingsThemeState createState() => _SettingsThemeState();
}

class _SettingsThemeState extends State<SettingsTheme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar('设置主题'),
      body: ListView.builder(itemBuilder: _itemBuilder, itemCount: themes.length,),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(top: 30, left: 10, right: 10),
      child: GestureDetector(//手势检测
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: themes[index],
            borderRadius: BorderRadius.all(Radius.circular(10))//设置圆角
          ),
          //Provider.of<ThemeViewmodel>(context).getColor == index
          child: Provider.of<ThemeViewModel>(context).getColor == index
          ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.done,
                color: Colors.white,
              ),
              SizedBox(width: 16,)
            ],
          ) : Row(),
        ),
        onTap: () async {
          SharedPreferences sp = await SharedPreferences.getInstance();//持久化操作
          sp.setInt("color", index);
          context.read<ThemeViewModel>().setColor(index);
        },
      ),
    );
  }
}

