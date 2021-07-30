import 'package:flutter/material.dart';
import 'package:zyl_app2/view/accounting/accounting_add.dart';
import 'package:zyl_app2/view/accounting/accounting_chart.dart';
import 'package:zyl_app2/view/accounting/accounting_list.dart';
import 'package:zyl_app2/view/love_image/love_image.dart';
import 'package:zyl_app2/view/menu-view.dart';
import '../view/user/register-view.dart';
import 'package:zyl_app2/view/theme/settings_theme.dart';
import 'package:zyl_app2/view/user/login-view.dart';

Map<String, WidgetBuilder> routes = {
  "/": (BuildContext context) => LoginView(),
  "menu": (BuildContext context) => MenuView(),
  "register": (BuildContext context) => RegisterView(),
  "theme": (BuildContext context) => SettingsTheme(),
  "accounting": (BuildContext context) => AccountingView(),
  "accounting/add": (BuildContext context) => AccountingAddView(),
  "accounting/chart": (BuildContext context) => AccountingChartView(),
  "loveImage": (BuildContext context) => LoveImageView(),
};