import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:test_fist/widgets/Tool.dart';
import 'package:test_fist/widgets/my_icons_icons.dart';
import '../Log/LogPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'EventSearch.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  List<String> TitleTime = const ["早上好","中午好","下午好","晚上好","早点休息~"];
  String nowTime = "";
  static String SearchValue = "";
  void initState()
  {
    super.initState();
    nowTime = TitleTime[getTime().getTitleTime()];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.black,
        title:Padding(
          padding: EdgeInsets.only(left: 45.w),
          child: Container(
              width: 352.w,
              height: 33.h,
              alignment: Alignment.centerRight,
              child:ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventSearch(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                ),
                child: Padding(
                    padding: EdgeInsets.all(5.r),
                    child:const Row(
                      children: [
                        Icon(Icons.search),
                        Text("搜索活动",style: TextStyle(color: Colors.grey),)
                      ],
                    )
                ),
              )
          ),
        )
        ,
        actions: <Widget>[ //导航栏右侧菜单
          IconButton(icon: Icon(Icons.login,color: Colors.blue,), onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context){
                  return const LogPage();
                })
            );
          }),
        ],

      ),
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
                        Text("${nowTime},XXX",
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
          body: EventViewList(context),
      ),
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
                        child: Text(""),
                       )
                  );
                }
            ),
      ),
    ),
  );
}

Widget EventViewList(BuildContext context)
{
  return ListView.builder(
      itemCount: 20,
      //itemExtent: 100,
      itemBuilder: (BuildContext context,int index){
        return Container(
          //width: 70,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //--------------------------------------
                  // 发帖人信息
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
                            "用户$index",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "20232420${index%9}",
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
              Padding(padding: EdgeInsets.all(20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-------------标题-------------
                    Text(
                      "标题$index",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        fontSize: 20.sp,),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    //----------------内容---------------------------
                    Text(
                      "内容${index}XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
                      style: TextStyle(fontSize: 14.sp),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
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

