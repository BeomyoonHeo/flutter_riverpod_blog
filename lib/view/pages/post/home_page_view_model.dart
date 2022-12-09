import 'package:blog/core/routers.dart';
import 'package:blog/domain/post/post.dart';
import 'package:blog/main.dart';
import 'package:blog/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homePageViewModel =
    StateNotifierProvider<HomePageViewModel, List<Post>>((ref) {
  AuthProvider ap = ref.read(authProvider);
  return HomePageViewModel([], ap)..initViewModel();
});

class HomePageViewModel extends StateNotifier<List<Post>> {
  AuthProvider ap;
  HomePageViewModel(super.state, this.ap);

  initViewModel() {
    //repository 접근해서 값 받아와서 state에 저장 - 비지니스 로직이 필요하다
    if (ap.isLogin) {
    } else {
      Navigator.pushNamed(navigatorKey.currentState!.context, Routers.joinForm);
    }
  }
}
