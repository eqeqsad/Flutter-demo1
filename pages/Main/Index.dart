import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/pages/Cart/Cart.dart';
import 'package:hm_shop/pages/Category/category.dart';
import 'package:hm_shop/pages/Home/home.dart';
import 'package:hm_shop/pages/Mine/mine.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/Usercontroller.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, String>> _tabList = [
    {
      // "icon":正常显示图标
      // “active_icon” :  激活显示的图标
      "text": "首页",
    },
    {"text": "分类"},
    {"text": "购物车"},
    {"text": "我的"},
  ];
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      // return BottomNavigationBarItem(
      //   icon: Image.asset(_tabList[index]["icon"]!, width: 24, height: 24),
      //   activeIcon: Image.asset(
      //     _tabList[index]["active_icon"]!,
      //     width: 24,
      //     height: 24,
      //   ),
      //   label: _tabList[index]["text"]!,
      // );
      return BottomNavigationBarItem(
        icon: Text(_tabList[index]["text"]!),
        label: _tabList[index]["text"]!,
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initUser();
  }

  final UserController _userController = Get.put(UserController());
  void _initUser() async {
    await tokenManager.init();
    if (tokenManager.getToken().isNotEmpty) {
      _userController.updateUserInfo(await getUserInfoAPI());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildren()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,
        onTap: (value) {
          setState(() => _currentIndex = value);
        },
        items: _getTabBarWidget(),
        currentIndex: _currentIndex, // 页面改变
      ),
    );
  }
}
