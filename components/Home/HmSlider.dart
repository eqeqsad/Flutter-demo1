import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmslider extends StatefulWidget {
  final List<BannerItem> bannerList;
  Hmslider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmsliderState createState() => _HmsliderState();
}

class _HmsliderState extends State<Hmslider> {
  CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;

  Widget _getSlider() {
    //flutter中获取屏幕参数的方法
    final double screenwidth = MediaQuery.of(context).size.width;
    return CarouselSlider(
      carouselController: _controller,
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: screenwidth,
        );
      }),
      options: CarouselOptions(
        autoPlayInterval: Duration(seconds: 5), //轮播图切换时间
        viewportFraction: 1.0,
        autoPlay: true,
        onPageChanged: (int index, reason) {
          _currentIndex = index;
          setState(() {});
        },
      ), //值表示图片占比 ,1.0 表示只显示一个图片
      // 0.5 表示显示两个图片
      // 0.25 表示显示四个图片
      // 0.1 表示显示一个图片
    );
  }

  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color.from(alpha: 0.4, red: 0, green: 0, blue: 0),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            "搜索",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _getDots() {
    return Positioned(
      bottom: 10,
      left: 0,
      right: 0,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                _controller.animateToPage(index);
              },
              child: AnimatedContainer(
                duration: Duration(seconds: 3),
                alignment: Alignment.center,
                height: 6,
                width: index == _currentIndex ? 40 : 20,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == _currentIndex
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);

    // return Container(
    //   height: 300,
    //   color: Colors.blue,
    //   alignment: Alignment.center,
    //   child: Text("轮播图", style: TextStyle(fontSize: 20, color: Colors.white)),
    // );
  }
}
