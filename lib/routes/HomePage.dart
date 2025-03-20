import 'package:flutter/material.dart';

class HomePageRoute extends StatefulWidget {
  const HomePageRoute({super.key});

  @override
  State<HomePageRoute> createState() => _HomePageRouteState();
}

class _HomePageRouteState extends State<HomePageRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello,XXX"),//用户名
      ),
      bottomNavigationBar: _BottomBar(),//学生或社团 person&event&home
      body: _Body(),//页面
    );
  }
}
Widget _BottomBar()
{
  int _indexselect = 0;
  return BottomNavigationBar(
      // 背景颜色
      backgroundColor: Colors.black,
      // 选中图标主题
      selectedIconTheme: IconThemeData(
        // 图标颜色
        color: Colors.blue,
        // 图标大小
        size: 32,
        // 图标透明度
        opacity: 1.0,
      ),
      // 未选中图标主题
      unselectedIconTheme: IconThemeData(
        color: Colors.blue[50],
        size: 24,
        opacity: 0.5,
      ),
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home)),
      BottomNavigationBarItem(icon: Icon(Icons.event)),
      BottomNavigationBarItem(icon: Icon(Icons.person)),
    ],
    currentIndex: _indexselect,
  );
}
/*
Widget _Body(int currentIndex) {
  // 根据currentIndex显示不同内容
  final List<Widget> pages = [
    const Center(child: Text("首页内容")),
    const Center(child: Text("活动列表")),
    const Center(child: Text("个人中心")),
  ];
  return pages[currentIndex];
}
*/
Widget _Body()
{
  return const Center(
    child: Text("waiting"),
  );
}
