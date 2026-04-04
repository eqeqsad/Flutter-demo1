//登录接口API

import 'package:hm_shop/constants/constants.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> params) async {
  return UserInfo.formJson(
    await dioRequest.post(HttpConstants.LOGIN, data: params),
  );
}

Future<UserInfo> getUserInfoAPI() async {
  return UserInfo.formJson(await dioRequest.get(HttpConstants.USER_PROFILE));
  
}
