import 'package:hm_shop/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  // 获取 SharedPreferences 持久化对象的实例对象
  Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  String _token = "";
  Future<void> init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  Future<void> setToken(String val) async {
    final prefs = await _getInstance();
    prefs.setString(GlobalConstants.TOKEN_KEY, val); //token写入到持久化对象中（磁盘）
    _token = val;
  }

  String getToken() {
    return _token;
  }

  Future<void> removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstants.TOKEN_KEY); //磁盘
    _token = ""; //内存
  }
}

final tokenManager = TokenManager();
