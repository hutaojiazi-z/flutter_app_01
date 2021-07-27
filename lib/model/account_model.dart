import 'package:zyl_app2/global/Global.dart';

Future getAccount(String date) async {
  return await Global.getInstance().dio.get(
      "/zxw/AccountingHistory",
      queryParameters: {
        "date": date
        }
      );

}