import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zyl_app2/global/global_theme.dart';
import 'package:zyl_app2/routes/routes.dart';
import 'package:zyl_app2/viewmodel/account_viewmodel.dart';
import 'package:zyl_app2/viewmodel/login_viewmodel.dart';
import 'package:zyl_app2/viewmodel/register_viewmodel.dart';
import 'package:zyl_app2/viewmodel/theme_viewmodel.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();//初始化完成回调
  //设置主题色
  SharedPreferences sp = await SharedPreferences.getInstance();//持久化操作
  int color = await sp.getInt("color") ?? 0; //?? 判断前面得是否为假
  ThemeViewModel themeViewModel = ThemeViewModel();
  themeViewModel.setColor(color);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ChangeNotifierProvider(create: (context) => themeViewModel),
      ChangeNotifierProvider(create: (context) => RegisterViewModel()),
      ChangeNotifierProvider(create: (context) => AccountViewModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final JPush jpush = new JPush();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    const bool inProduction = const bool.fromEnvironment("dart.vm.product");//判断是否是生产模式
    try {
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
            print("flutter onReceiveNotification: $message");
          }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
      }, onReceiveNotificationAuthorization:
          (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
      });
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }


    print("开发模式" + inProduction.toString());
    jpush.setup(
      appKey: "87b71e05fa97e40e2a7672c7", //你自己应用的 AppKey
      channel: "developer-default",
      production: inProduction,
      debug: inProduction, //debug日志 true=打印
    );
    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print("flutter get registration id : $rid");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () =>
      MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Dem333o',
        // theme: ThemeData(
        //     primarySwatch: themes[Provider.of<ThemeViewModel>(context).getColor],
        //     visualDensity: VisualDensity.adaptivePlatformDensity
        // ),
        // theme: ThemeData(
        theme: ThemeData(
          //配置应用程序的 亮色 暗色
          // brightness: Brightness.light,
          //主背景颜色
          // primaryColor: themes[Provider
          //   .of<ThemeViewModel>(context)
          //   .getColor],//主题色
          textTheme: TextTheme(
            button: TextStyle(//label文字颜色
                color: themes[Provider
                    .of<ThemeViewModel>(context)
                    .getColor]
            ),
          ),
          //配置应用程序的前景色
          ///例如进度条的前景色 开关switch 选中的颜色, 单选框选中的颜色
          ///例如: 文本输入框光标的颜色以及文本输入框默认的下划线的颜色
          ///
          // accentColor: themes[Provider
          //     .of<ThemeViewModel>(context)
          //     .getColor],
          ///设置 ElevatedButton按钮 输入框颜色  主背景颜色
          primarySwatch: themes[Provider
              .of<ThemeViewModel>(context)
              .getColor],
          // primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        routes: routes,
      )
    );
  }
}
