import 'package:flutter/material.dart';
import 'package:test_fist/commons/Global.dart';
import 'package:test_fist/widgets/Tool.dart';
import 'package:test_fist/routes/ViewClub/ClubMainPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCollection extends StatefulWidget {
  const MyCollection({super.key});

  @override
  State<MyCollection> createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的收藏"),
        bottom: TabBar(
          controller: _tabController,
            tabs:[
              Tab(text: "收藏的活动", ),
              Tab(text: "收藏的社团",)
            ],
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.blue,
            labelStyle: TextStyle(fontSize: 20.sp),
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(fontSize: 20.sp),
            ),

      ),
      body: TabBarView(
          controller: _tabController,
          children: [
            MyCollectedEvent(),
            MyCollectedClub(),
      ]),
    );
  }
}
class MyCollectedClub extends StatefulWidget {
  const MyCollectedClub({super.key});

  @override
  State<MyCollectedClub> createState() => _MyCollectedClubState();
}

class _MyCollectedClubState extends State<MyCollectedClub> {
  @override
  Widget build(BuildContext context) {
    return  CustomScrollView(
      slivers: [
        SliverPadding(padding: EdgeInsets.symmetric(vertical: 10.h),
          sliver: SliverGrid(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 40.0.h,
                crossAxisSpacing: 20.0.h,
                childAspectRatio: 4.0,
              ),
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClubMainPage(ClubName: GlobalInformation().collectedClubs[index]),
                        ),
                      );
                      setState(() {});
                    },
                    child: Padding(padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      child: collectedClub(context, index),
                    ),
                  );
                },
              childCount: GlobalInformation().collectedClubs.length
            ),
          )
        )
      ],
    );

  }
}


class MyCollectedEvent extends StatefulWidget {
  const MyCollectedEvent({super.key});

  @override
  State<MyCollectedEvent> createState() => _MyCollectedEventState();
}

class _MyCollectedEventState extends State<MyCollectedEvent> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Widget collectedClub(BuildContext context,int index)
{
  return Container(
    //-----------------样式------------------------
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.r),
        boxShadow: [BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2.h,
            blurRadius: 5.h
        ),]
    ),
    //-------------------------------------------
    child: Row(
      children: [
        ClipRRect(
          borderRadius:  const BorderRadius.only( topLeft:Radius.circular(40),bottomLeft: Radius.circular(40)),
          child: AspectRatio(
            aspectRatio: 1.w,//图片尺寸
            child: Image.asset("assets/images/twt.png",
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container( // 错误处理
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //截取固定长度的文字
                  truncateText(GlobalInformation().collectedClubs[index], 15),
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2
                  ),
                  //maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: const Text(
                    "育人实践基地",
                    //style: _kLabelStyle,
                    strutStyle: StrutStyle(height: 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        //添加选项


      ],
    ),

  );
}