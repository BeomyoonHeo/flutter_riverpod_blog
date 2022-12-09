import 'package:blog/core/size.dart';
import 'package:blog/view/pages/post/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    HomePageViewModel hvm = ref.watch(homePageViewModel.notifier);
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (scaffoldKey.currentState!.isDrawerOpen) {
            scaffoldKey.currentState!.openEndDrawer();
          } else {
            scaffoldKey.currentState!.openDrawer();
          }
        },
        child: Icon(Icons.code),
      ),
      drawer: _navigation(context),
      appBar: _buildAppBarTitle(hvm),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {},
        child: ListView.separated(
          itemCount: 5,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: ListTile(
                leading: Text("아이디"),
                title: Text("제목"),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }

  AppBar _buildAppBarTitle(HomePageViewModel hvm) {
    if (hvm.ap.isLogin) {
      return AppBar(
        title: Text("로그인한 유저 이름 : ${hvm.ap.jwtToken}"),
      );
    } else {
      return AppBar(
        title: Text("로그인 되지 않은 상태 입니다."),
      );
    }
  }

  Widget _navigation(BuildContext context) {
    return Container(
      width: getDrawerWidth(context),
      height: double.infinity,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "글쓰기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  //Navigator.pop(context);
                  scaffoldKey.currentState!.openEndDrawer();
                },
                child: Text(
                  "회원정보보기",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {},
                child: Text(
                  "로그아웃",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
