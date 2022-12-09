import 'package:blog/core/routers.dart';
import 'package:blog/view/pages/post/detail_page.dart';
import 'package:blog/view/pages/post/home_page.dart';
import 'package:blog/view/pages/post/update_page.dart';
import 'package:blog/view/pages/post/write_page.dart';
import 'package:blog/view/pages/user/join_page.dart';
import 'package:blog/view/pages/user/login_page.dart';
import 'package:blog/view/pages/user/user_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool isToken = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final pref = await SharedPreferences.getInstance();
      String? jwt = pref.getString('jwtToken');
      isToken = jwt != null ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: isToken ? Routers.home : Routers.joinForm,
      routes: {
        Routers.joinForm: (context) => JoinPage(),
        Routers.loginForm: (context) => LoginPage(),
        Routers.home: (context) => HomePage(),
        Routers.detail: (context) => DetailPage(),
        Routers.updateForm: (context) => UpdatePage(),
        Routers.writeForm: (context) => WritePage(),
        Routers.userInfo: (context) => UserInfoPage(),
      },
    );
  }
}
