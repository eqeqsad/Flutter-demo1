import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hm_shop/api/mine.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/Mine/HmGuess.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/Usercontroller.dart';
import 'package:hm_shop/viewmodels/home.dart';
import 'package:hm_shop/viewmodels/user.dart';

class MineView extends StatefulWidget {
  MineView({Key? key}) : super(key: key);

  @override
  _MineViewState createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  Widget _getLogout() {
    //问题1: 登录完成后不显示退出登录按钮，需刷新页面后才显示
    //问题2: 退出登录后，需要刷新页面才能不显示退出登录按钮
    //解决方法: 添加Obx((){})，实时监听_userController.user.value.id变化
    return _userController.user.value.id.isNotEmpty
        ? Expanded(
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("提示", textAlign: TextAlign.center),
                      content: Text(
                        "确定退出登录吗？",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            await tokenManager.removeToken();
                            _userController.updateUserInfo(
                              UserInfo.formJson({}),
                            );
                            Navigator.pop(context);
                          },
                          child: Text(
                            "确认",
                            style: TextStyle(
                              color: const Color.fromARGB(255, 57, 50, 50),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "取消",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                "退出登录",
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.end,
              ),
            ),
          )
        : Text("");
  }

  final UserController _userController = Get.find();
  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [Color(0xFFFFF2E8), Color(0xFFE6E6E6)],
        ),
      ),
      padding: const EdgeInsets.only(top: 80, bottom: 20, left: 20, right: 40),
      child: Row(
        children: [
          Obx(() {
            return CircleAvatar(
              radius: 26,
              backgroundImage: _userController.user.value.id.isNotEmpty
                  ? NetworkImage(_userController.user.value.avatar)
                  : AssetImage("lib/assets/food1.png"), //const表示图片是静态的，不会改变
              backgroundColor: Colors.white,
            );
          }),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  //.obs 创建的可观察数据，必须通过 Obx / GetX 包裹的 Widget 才能建立监听关系
                  //Obx中必须得有可监测的响应数据
                  return GestureDetector(
                    onTap: () {
                      if (_userController.user.value.id.isEmpty)
                        Navigator.pushNamed(context, "/login");
                    },
                    child: Text(
                      _userController.user.value.id.isNotEmpty
                          ? _userController.user.value.account
                          : "立即登录",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Obx(() => _getLogout()),
        ],
      ),
    );
  }

  Widget _buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 197, 153),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Image.asset("lib/assets/food2.png", width: 10, height: 10),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "会员中心",
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(128, 44, 26, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Color.fromRGBO(126, 43, 26, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("立即开通", style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction() {
    Widget item(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            item("lib/assets/food3.png", "我的收藏"),
            item("lib/assets/food4.png", "我的足迹"),
            item("lib/assets/food1.png", "我的客服"),
          ],
        ),
      ),
    );
  }

  Widget _buildIOrderMoule() {
    Widget orderItem(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "我的订单",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              orderItem("lib/assets/goods1.png", "全部订单"),
              orderItem("lib/assets/goods2.png", "待付款"),
              orderItem("lib/assets/goods3.png", "待发货"),
              orderItem("lib/assets/goods4.png", "待收货"),
              orderItem("lib/assets/food2.png", "待评价"),
            ],
          ),
        ],
      ),
    );
  }

  List<GoodDetailItem> _guessList = [];
  Map<String, dynamic> _params = {"page": 1, "pageSize": 10};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getGuessList();
    _registerEvent();
  }

  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels <= _controller.position.maxScrollExtent) {
        _getGuessList();
      }
    });
  }

  bool _isLoading = false;
  bool _hasMore = true;
  void _getGuessList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    final res = await getGuessListAPI(_params);
    _isLoading = false;
    _guessList.addAll(res.items);
    _guessList = res.items;
    if (_params["page"] >= res.Pages) {
      _hasMore = false;
      return;
    }
    _params["page"]++;
    setState(() {});
  }

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildVipCard()),
        SliverToBoxAdapter(child: _buildQuickAction()),
        SliverToBoxAdapter(child: _buildIOrderMoule()),
        SliverPersistentHeader(delegate: HmGuess(), pinned: true),
        Hmmorelist(recommendList: _guessList),
      ],
    );
  }
}
