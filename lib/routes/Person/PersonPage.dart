import 'package:flutter/material.dart';
import 'package:test_fist/commons/Global.dart';
import 'package:test_fist/main.dart';
import 'package:test_fist/routes/Settings/PersonSettings.dart';
import 'package:test_fist/routes/Notification/NotificationCenter.dart';
import 'MyCollection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_fist/widgets/my_icons_icons.dart';
import 'package:test_fist/routes/Log/LogPage.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          logOut(context),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => NotificationCenter(),
              ),
              );
            },
            icon: Icon(Icons.email_outlined, size: 30.sp),

          ),
          IconButton(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PersonSettings(),
              ),
            );
            },
            icon: Icon(MyIcons.setting_2, size: 30.sp),
          ),
        ],
      ),
      body:  Column(
        children: [
          //-----------------个人信息-----------------------------------
          Padding(
              padding:  EdgeInsets.all(16.0.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //--------------------------------------
                  // 头像部分
                      Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey

                      ),
                    ),
                       Container(width: 16.w),
                    //----------------------------------------------
                    // 用户信息
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              GlobalInformation().userInformation['name'],
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                fontSize:20.sp,),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              GlobalInformation().userInformation['school_number'].toString(),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 17.sp,
                              ),
                            ),
                          ]),
                    ),
                     Container(width: 16.w),
                    //-----------------------------------------------------
                    // 社团标签
                    Container(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 12.w
                          , vertical: 8.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6CB2F3),
                        borderRadius: BorderRadius.circular(20.r),),

                        child:  Text(
                          "天外天工作室",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          //-----------------------功能按钮----------------------------------
          Padding(padding: EdgeInsets.all(16.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                  Container(
                    //alignment: Alignment.topCenter,
                    decoration: ButtonStyle(),
                    height: 100.h,
                    width: 120.w,
                    child: InkWell(
                      onTap: (){},
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(MyIcons.message_blue,color: Colors.blueAccent,size: 24,),
                          Text("消息中心",style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w900
                          ),)
                        ],
                      ),

                    ),
                  ),
                Container(
                  //alignment: Alignment.center,
                  decoration: ButtonStyle(),
                  height: 100.h,
                  width: 120.w,
                  child: InkWell(
                    onTap: (){},
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(MyIcons.heart_red,color: Colors.red,size: 24,),
                        Text("我的点赞",style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w900
                        ),)
                      ],
                    ),
                  ),
                ),
                Container(
                  //alignment: Alignment.center,
                  height: 100.h,
                  width: 120.w,
                  decoration: ButtonStyle(),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyCollection(),
                        ),
                      );
                    },
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(MyIcons.star_yellow,color: Color(0xFFFFB21B),size: 24,),
                        Text("我的收藏",style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w900
                        ),)
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}

BoxDecoration ButtonStyle()
{
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
      boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 2.r,
          blurRadius: 5.r
      ),]
  );
}


Widget logOut(BuildContext context)
{
  return IconButton(icon: Icon(Icons.login,size: 30.sp,), onPressed: () {
    showDialog
      (context: context,
        builder: (context){
          return AlertDialog(
            title: const Text("确认退出登录？"),
            actions: [
              IconButton(onPressed: (){
                GlobalInformation().clearUser();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){
                      return const MyApp();
                    })
                );
              }, icon: const Icon(Icons.done_rounded)),
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Icons.close_rounded)),
            ],
          );
        }
    );
  });
}