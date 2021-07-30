import 'package:zyl_app2/global/Global.dart';

Future getAccountingTypes(int action) async {
  return await Global.getInstance().dio.get(
    "/zxw/AccountingType",
    queryParameters: {
      "action": action
    }
  );
}

Future insertAccounting(String json) async {
  return await Global.getInstance().dio.put(
      "/zxw/AccountingHistory",
      queryParameters: {
        "json": json
      }
  );
}