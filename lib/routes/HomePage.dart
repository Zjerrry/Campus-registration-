import 'package:flutter/material.dart';
import 'package:test_fist/routes/ViewClub/ClubListPage.dart';
import 'ViewEvent/EventView.dart';
import 'package:test_fist/routes/Person/PersonPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_fist/widgets/my_icons_icons.dart';

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
    return Container(
        height: 100.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r),topRight: Radius.circular(40.r)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  offset: Offset(0,-8.h),
                  spreadRadius: 2.r,
                  blurRadius: 40.r
              )
            ]
        ),
        child: BottomAppBar(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomButton(MyIcons.home_2, 0, 32,selectedIndex==0?Colors.blue:Colors.grey),
              BottomButton(MyIcons.profile_2user, 1, 32,selectedIndex==1?Colors.blue:Colors.grey),
              BottomButton(MyIcons.user, 2, 32,selectedIndex==2?Colors.blue:Colors.grey),
            ],
          ),
        )
    );
  }
  Widget BottomButton(IconData icons,int index,double size,Color color)
  {
    return GestureDetector(
        onTap: ()=>onSelected(index),
        child: Icon(icons,size: size.r,color: color,)
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
