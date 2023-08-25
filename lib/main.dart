import 'package:demo2/view/user_list.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation with GetX',
      initialRoute: '/home', // Set your initial route as needed.
      getPages: [
        // GetPage(name: '/splash', page: () => SplashPage()),
        GetPage(name: '/home', page: () => UserListPage()),

      ],
    );
  }
}
