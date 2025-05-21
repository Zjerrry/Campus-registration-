import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:test_fist/commons/Global.dart';
import 'package:test_fist/widgets/Tool.dart';
import 'package:test_fist/widgets/my_icons_icons.dart';
import '../Log/LogPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'EventSearch.dart';
import 'package:test_fist/models/dio/getNet.dart';
import 'package:test_fist/routes/Event_Release/Event_Release.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  List<String> TitleTime = const ["早上好","中午好","下午好","晚上好","早点休息~"];
  String nowTime = "";

  bool _isLoad = true;
  List<Map<String,dynamic>> eventList = [];

  Future<void> loadEvent() async {
    final response = await GetNet().fetchListOfEvent();
    setState(() {
      eventList = response;
      _isLoad = false;
    });
  }

  void initState()
  {
    super.initState();
    nowTime = TitleTime[getTime().getTitleTime()];
    loadEvent();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Padding(
          padding: EdgeInsets.symmetric(horizontal:5.w),
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return const EventSearch();
                  })
              );
            },
            child: Container(
              height: 31.h,
              padding: EdgeInsets.only(left: 20.r,right: 20.r),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.r),
                  color: Colors.white
              ),
              child:Padding(
                  padding: EdgeInsets.all(5.r),
                  child:Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.w),
                        child: Icon(Icons.search,
                          size: 25.sp,
                          color: Colors.black45,
                        ),),
                      Text("搜索活动",style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      ),)
                    ],
                  )
              ),

            ),
          )
        ),
      ),
      floatingActionButton:FloatBotton(context),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context,bool inner){
            return [
              SliverToBoxAdapter(
                child:Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 33.h,
                    width: 392.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.blue[50]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10.w,),
                        Text("${nowTime},${GlobalInformation().userInformation['name']}",
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold
                        ),
                      ),]
                    )
                  ),
                )

              ),
              TopImageSliver(context)
            ];
          },
          body: _isLoad?const Center(child: CircularProgressIndicator()):EventViewList(context),
      ),
    );
  }
  Widget FloatBotton(BuildContext context)
  {
    return FloatingActionButton(
      onPressed:  ()
      {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context){
              return const EventReleasePage();
            })
        ).then((e){
          setState(() {
            loadEvent();
          });
        });
      },
      backgroundColor: Colors.blue,
      shape: const CircleBorder(),
      child: const Icon(Icons.add,color: Colors.white,),
    );


  }
  Widget EventViewList(BuildContext context)
  {
    return ListView.builder(
        itemCount: eventList.length,
        itemBuilder: (BuildContext context,int index){
          final event = eventList[index];
          final time = DateTime.parse(jsonDecode(event['publish_time']));

          return SizedBox(
            //width: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //--------------------------------------
                      // 发帖人信息
                      //---- 头像 ----
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration:  BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[350]

                          ),
                        ),
                      ),

                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                event['publisher_name'].toString(),
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                event['publisher_schoolnumber'].toString(),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 17.sp,
                                ),
                              ),
                            ]),
                      ),

                    ],
                  ),
                  //-----------------------------------------------------------
                  //--------------活动内容---------------------------------------
                  Padding(padding: EdgeInsets.only(top:20.h,left: 20.w,right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //-------------标题-------------
                        Text(
                          event['title'],
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        //----------------内容---------------------------
                        Text(
                          event['content'],
                          style: TextStyle(fontSize: 14.sp),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        //----发布时间----
                        SizedBox(height: 10.h,),
                        Text('${time.year}-${time.month}-${time.day}   ${time.hour}:${time.minute}',style: TextStyle(fontSize: 14.sp,color: Colors.grey),)
                      ],
                    ),
                  ),
                  //-----------------------------------------------------------------------
                  //--------------------功能键----------------------------------------------
                  Padding(padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        //评论
                        IconButton(onPressed: (){},
                          icon: const Icon(MyIcons.message),
                        ),
                        //点赞
                        IconButton(onPressed: (){}, icon: const Icon(MyIcons.like_1)),
                        //收藏
                        IconButton(onPressed: (){}, icon: const Icon(Icons.thumb_down_alt_outlined)),
                      ],
                    ),
                  )
                ]
            ),
          );
        }
    );
  }

}
//顶部滚动显示
Widget TopImageSliver(BuildContext context)
{
  return SliverToBoxAdapter(
    child: Padding(padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical:10.h ),
      child: Container(
            height: 120.h,
            width: 378.w,
            child: Swiper(
                itemCount: 5,
                loop: true,
                outer: true,
                autoplay:true,
                autoplayDelay:5000,
                itemBuilder: (BuildContext context,int index)
                {
                  return Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            color: Colors.grey[300]
                        ),
                        child: const Text(""),
                       )
                  );
                }
            ),
      ),
    ),
  );
}
//---- 活动显示 ----


