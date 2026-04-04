import 'package:hm_shop/constants/constants.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<GoodsDetailsItems> getGuessListAPI(Map<String, dynamic> params) async {
  return GoodsDetailsItems.formJson(
    await dioRequest.get(HttpConstants.GUESS_LIST, params: params),
  );
}
