class GlobalConstants {
  static const String BASE_URL = "https://meikou-api.itheima.net";
  static const int TIMEOUT = 10;
  static const String SUCCESS_CODE = "1";
  static const String TOKEN_KEY = "token";
}

class HttpConstants {
  static const String BANNER_LIST = "/home/banner";
  static const String CATEGORY_LIST = "/home/category";
  static const String PRODUCT_LIST = "/home/product";
  static const String IN_VOGUE_LIST = "/hot/inVogue";
  static const String ONE_STOP_LIST = "/hot/oneStop";
  static const String RECOMMEND_LIST = "/home/recommend";
  static const String LOGIN = "/login";
  static const String GUESS_LIST =
      "/home/goods/guessLike"; //返回的结构体是GoodsItems类型
  //1.请求地址有
  //2.请求类型是GoodsItems类型，该类型包含 items属性,该属性是List<GoodsItem>类型
  //3.HmMoreList要的是List<GoodsDetailItem>类型
  //总结：要的是List<GoodsDetailItem>类型，但是实际是GoodsItem类型，所以要进行转换

  static const String USER_PROFILE = "/member/profile";
}
