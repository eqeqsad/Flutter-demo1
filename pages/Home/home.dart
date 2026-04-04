import 'package:flutter/material.dart';
import 'package:hm_shop/api/api.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/Hmsuggestion.dart';
import 'package:hm_shop/utils/Toastutils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  List<GoodDetailItem> _recommendList = [];
  List<CategoryItem> _categoryList = [];
  List<BannerItem> _bannerList = [
    // BannerItem(
    //   id: "1",
    //   imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
    // ),
    // BannerItem(
    //   id: "2",
    //   imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png",
    // ),
    // BannerItem(
    //   id: "3",
    //   imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
    // ),
  ];

  List<Widget> _getScollChildren() {
    return [
      SliverToBoxAdapter(child: Hmslider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      //SliverGrid SliverList只能纵向排列
      SliverToBoxAdapter(child: Hmcategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Hmsuggestion(specialRecommendResult: _specialRecommendResult),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Hmhot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Hmhot(result: _oneStopResult, type: "oneStop"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      Hmmorelist(recommendList: _recommendList),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState(); //initState() => build() => 下拉刷新组件 =>
    _registerEvent();
    Future.microtask(() {
      //microtask微任务，确保在build()执行完成后执行
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }

  Future<void> _registerEvent() async {
    _controller.addListener(() {
      if (_controller.position.pixels >= //pixels 是当前滚动的距离
          (_controller.position.maxScrollExtent)) {
        //window最大距离-50不会触发滚动事件
        _getRecommendList();
      }
    });
  }

  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    int requestLimit = _page * 8;
    try {
      _recommendList = await getRecommendListAPI({"limit": requestLimit});
    } catch (e) {
      print("获取推荐列表失败: $e");
    } finally {
      _isLoading = false;
      setState(() {});
      if (_recommendList.length < requestLimit) {
        _hasMore = false;
        return;
      }
      _page++;
    }
  }

  //获取全城推荐列表
  Future<void> _getOneStopList() async {
    try {
      _oneStopResult = await getOneStopListAPI();
    } catch (e) {
      print("获取全城推荐列表失败: $e");
    } finally {}
  }

  //获取热门推荐列表
  Future<void> _getInVogueList() async {
    try {
      _inVogueResult = await getInVogueListAPI();
    } catch (e) {
      print("获取热门推荐列表失败: $e");
    } finally {}
  }

  //获取特惠推荐列表
  Future<void> _getProductList() async {
    try {
      _specialRecommendResult = await getProductListAPI();
    } catch (e) {
      print("获取特惠推荐列表失败: $e");
    } finally {}
  }

  //获取banner列表
  Future<void> _getBannerList() async {
    try {
      _bannerList = await getBannerListAPI();
    } catch (e) {
      print("获取banner列表失败: $e");
    } finally {}
  }

  //获取分类列表
  Future<void> _getCategoryList() async {
    try {
      _categoryList = await getCategoryListAPI();
    } catch (e) {
      print("获取分类列表失败: $e");
    } finally {}
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getProductList();
    await _getInVogueList();
    await _getOneStopList();
    await _getCategoryList();
    await _getBannerList();
    await _getRecommendList();
    _paddingTop = 0;
    setState(() {});
    ToastUtils.showToast(context, "简单");
  }

  final ScrollController _controller = ScrollController();
  double _paddingTop = 0;
  //GlobalKey是一个方法，可以创建一个key绑定到Widget上，进行操作
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(top: _paddingTop),
        child: CustomScrollView(
          controller: _controller,
          slivers: _getScollChildren(),
        ),
      ),
    );
  }
}
