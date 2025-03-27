import 'package:flutter/material.dart';
import 'package:test_fist/routes/ViewClub/ClubListPage.dart';
import 'package:test_fist/routes/Event%20Release/Event%20Release.dart';
import 'ViewEvent/EventView.dart';
import 'package:test_fist/routes/Person/PersonPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      bottomNavigationBar: _BottomBar(
        selectedIndex: _selectedIndex,
        onSelected: _onItemTapped,
      ),//学生或社团 person&event&home

      floatingActionButton: FloatingActionButton(
        onPressed:  ()
        {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context){
                return const EventReleasePage();
              })
          );
        },
        child: Icon(Icons.add,),
      ),
      body: _Body(_selectedIndex),//页面

    );
  }
}
//底部导航栏
class _BottomBar extends StatelessWidget {
  const _BottomBar
      ({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  final int selectedIndex;
  final Function(int) onSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // 背景颜色
      //backgroundColor: Colors.black,
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
        color: Colors.grey,
        size: 24,
        opacity: 0.5,
      ),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页',),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: '社团',),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '个人',),
      ],
      onTap: (index) =>
        onSelected(index)

      ,// 添加点击回调
      currentIndex: selectedIndex, // 绑定状态
    );
  }
}

Widget _Body(int currentIndex) {
  // 根据currentIndex显示不同内容
  final List<Widget> pages = [
    const EventView(),
    const ClubListPage(),
    const PersonPage()
  ];
  return pages[currentIndex];
}