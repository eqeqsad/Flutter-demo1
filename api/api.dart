import 'dart:io';

import 'package:hm_shop/constants/constants.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListAPI() async {
  return ((await dioRequest.get(HttpConstants.BANNER_LIST)) as List).map((
    item,
  ) {
    return BannerItem.formJson(item as Map<String, dynamic>);
  }).toList();
}

Future<List<CategoryItem>> getCategoryListAPI() async {
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((
    item,
  ) {
    return CategoryItem.formJson(item as Map<String, dynamic>);
  }).toList();
}

Future<SpecialRecommendResult> getProductListAPI() async {
  return SpecialRecommendResult.formJson(
    await dioRequest.get(HttpConstants.PRODUCT_LIST),
  );
}
Future<SpecialRecommendResult> getInVogueListAPI() async {
  return SpecialRecommendResult.formJson(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}
Future<SpecialRecommendResult> getOneStopListAPI() async {
  return SpecialRecommendResult.formJson(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}
Future<List<GoodDetailItem>> getRecommendListAPI(Map<String, dynamic> params) async {
  return ((await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params)) as List).map((
    item,
  ) {
    return GoodDetailItem.formJson(item as Map<String, dynamic>);
  }).toList();
}


