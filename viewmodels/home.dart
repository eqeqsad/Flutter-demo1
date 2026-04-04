class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  //扩展一个factory工厂函数，用于从json字符串创建BannerItem实例对象
  factory BannerItem.formJson(Map<String, dynamic> json) {
    return BannerItem(id: json["id"], imgUrl: json["imgUrl"] ?? "");
  }
}

//flutter 必须强制转换
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  factory CategoryItem.formJson(Map<String, dynamic> json) {
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] == null
          ? null
          : (json["children"] as List)
                .map(
                  (item) => CategoryItem.formJson(item as Map<String, dynamic>),
                )
                .toList(),
    );
  }
}

// 特惠推荐数据模型
class GoodsItem {
  String id;
  String name;
  String? desc;
  String picture;
  String price;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.picture,
    required this.price,
    required this.orderNum,
  });
  factory GoodsItem.formJson(Map<String, dynamic> json) {
    return GoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"] ?? "",
      picture: json["picture"] ?? "",
      price: json["price"] ?? "",
      orderNum: int.tryParse(json["orderNum"].toString()) ?? 0,
    );
  }
}

class GoodsItems {
  int counts;
  int pageSize;
  int Pages;
  int Page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.Pages,
    required this.Page,
    required this.items,
  });
  factory GoodsItems.formJson(Map<String, dynamic> json) {
    return GoodsItems(
      counts: int.tryParse(json["counts"].toString()) ?? 0,
      pageSize: int.tryParse(json["pageSize"].toString()) ?? 0,
      Pages: int.tryParse(json["Pages"].toString()) ?? 0,
      Page: int.tryParse(json["Page"].toString()) ?? 0,
      items: (json["items"] as List)
          .map((item) => GoodsItem.formJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({required this.id, required this.title, required this.goodsItems});
  factory SubType.formJson(Map<String, dynamic> json) {
    return SubType(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: GoodsItems.formJson(
        json["goodsItems"] as Map<String, dynamic>,
      ),
    );
  }
}

class SpecialRecommendResult {
  String id;
  String title;
  List<SubType> subTypes;
  SpecialRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  factory SpecialRecommendResult.formJson(Map<String, dynamic> json) {
    return SpecialRecommendResult(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes: (json["subTypes"] as List)
          .map((item) => SubType.formJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class GoodDetailItem extends GoodsItem {
  int payCount = 0;

  GoodDetailItem({
    required super.id,
    required super.name,

    required super.picture,
    required super.price,
    required super.orderNum,
    required this.payCount,
  }) : super(desc: "");
  factory GoodDetailItem.formJson(Map<String, dynamic> json) {
    return GoodDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      price: json["price"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"].toString()) ?? 0,
      payCount: int.tryParse(json["payCount"].toString()) ?? 0,
    );
  }
}

class GoodsDetailsItems {
  int counts;
  int pageSize;
  int Pages;
  int Page;
  List<GoodDetailItem> items;
  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.Pages,
    required this.Page,
    required this.items,
  });
  factory GoodsDetailsItems.formJson(Map<String, dynamic> json) {
    return GoodsDetailsItems(
      counts: int.tryParse(json["counts"].toString()) ?? 0,
      pageSize: int.tryParse(json["pageSize"].toString()) ?? 0,
      Pages: int.tryParse(json["Pages"].toString()) ?? 0,
      Page: int.tryParse(json["Page"].toString()) ?? 0,
      items: (json["items"] as List)
          .map((item) => GoodDetailItem.formJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}


