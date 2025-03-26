import 'package:flutter/material.dart';
import 'package:test_fist/widgets/ClubSearch.dart';
class HomePageRoute extends StatefulWidget {
  const HomePageRoute({super.key});

  @override
  State<HomePageRoute> createState() => _HomePageRouteState();
}

class _HomePageRouteState extends State<HomePageRoute> {
  int _selectedIndex = 0;
  String SearchValue = "";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            // 保留原始标题
            Text(
              "Hello,XXX",//用户名
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            // 添加搜索栏
            const SizedBox(width: 8),
            Expanded(
              child: TopSearchBar(

                lable: "搜索社团",
                SearchValue: SearchValue,
                onSearch: (value){
                  setState(() {
                    SearchValue = value;
                    Search(SearchValue);
                  });
                },
                // 初始值为空
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomBar(
        selectedIndex: _selectedIndex,
        onSelected: _onItemTapped,
      ),//学生或社团 person&event&home
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
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页',),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: '活动',),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: '个人',),
      ],
      onTap: (index) => onSelected(index),// 添加点击回调
      currentIndex: selectedIndex, // 绑定状态
    );
  }
}

Widget _Body(int currentIndex) {
  // 根据currentIndex显示不同内容
  final List<Widget> pages = [
    const Center(child: Text("首页内容")),
    const Center(child: Text("活动列表")),
    const Center(child: Text("个人中心")),
  ];
  return pages[currentIndex];
}