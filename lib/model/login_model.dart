import 'package:zyl_app2/global/Global.dart';
import 'package:zyl_app2/utils/rsa/rsa_utils.dart';

Future loginModel(String user, String pass) async {
  String pwd = await encodeString(pass);
  return await Global.getInstance().dio.post(
    "/zxw/user",
    queryParameters: {
      "username": user,
      "password": pwd,
    },
  );
}

Future tokenLoginModel() async {
  return await Global.getInstance().dio.get("/zxw/user");
}
