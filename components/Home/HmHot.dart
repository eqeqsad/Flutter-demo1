import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class Hmhot extends StatefulWidget {
  final SpecialRecommendResult result;
  final String type;
  Hmhot({Key? key, required this.result, required this.type}) : super(key: key);

  @override
  _HmhotState createState() => _HmhotState();
}

class _HmhotState extends State<Hmhot> {
  //获取前两条数据

  List<GoodsItem> get _items {
    //get 表示不用()就可以调用, 属性调用: .xxx，方法调用: .xxx()，
    if (widget.result.subTypes.isEmpty) {
      return [];
    }
    return widget.result.subTypes.first.goodsItems.items.take(2).toList();
  }

  List<Widget> _getChildrenList() {
    return _items.map((item) {
      return Container(
        width: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 垂直居中
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.picture,
                width: 80,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/default.png",
                    width: 80,
                    height: 100,
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            Text(
              "￥${item.price}",
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromRGBO(88, 86, 24, 20),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "step" ? "一战买全" : "爆款推荐",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700, // 加粗
            color: const Color.fromARGB(255, 86, 24, 20),
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "step" ? "精选省略" : "最受欢迎",
          style: TextStyle(
            fontSize: 12,
            color: const Color.fromARGB(255, 122, 58, 58),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.type == "step"
              ? const Color.fromARGB(255, 249, 247, 219)
              : const Color.fromARGB(255, 211, 228, 240),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getChildrenList(),
            ),
          ],
        ),
      ),
    );
  }
}
