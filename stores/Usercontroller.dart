import 'package:get/get.dart';
import 'package:hm_shop/viewmodels/user.dart';

class UserController extends GetxController {
  var user = UserInfo.formJson(
    {},
  ).obs; //.obs 是一个观察者，用于监听 user 变化的变化,若想取值,则需要使用 user.value 来获取值

  updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
