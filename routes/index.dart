import 'package:flutter/material.dart';
import 'package:hm_shop/pages/Login/Login.dart';
import 'package:hm_shop/pages/Main/Index.dart';

Widget getRootWidget() {
  return MaterialApp(initialRoute: "/", routes: getRootRoutes());
}

Map<String, Widget Function(BuildContext)> getRootRoutes() {
  return {"/": (context) => MainPage(), "login": (context) => LoginPage()};
}
