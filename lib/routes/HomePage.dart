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
      bottomNavigationBar: _BottomBar(),//学生或社团
      body: _Body(),//页面
    );
  }
}

Widget _BottomBar()
{
  int _indexselect = 0;
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home))//待添加
    ],
    currentIndex: _indexselect,
  );
}

Widget _Body()
{
  return const Center(
    child: Text("waiting"),
  );
}

