import 'package:zyl_app2/global/Global.dart';

Future registerModel(String json) async {
  return await Global.getInstance().dio.post(
    "/zxw/user/register",
    queryParameters: {
      "json": json,
    },
  );
}
