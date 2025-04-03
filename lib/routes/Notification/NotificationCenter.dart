import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_fist/widgets/my_icons_icons.dart';

class NotificationCenter extends StatefulWidget {
  @override
  State<NotificationCenter> createState() => _NotificationCenterState();
}
//暂时框架
class _NotificationCenterState extends State<NotificationCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('消息', style: TextStyle(fontSize: 24.sp)),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(16.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  //alignment: Alignment.topCenter,
                  //decoration: ButtonStyle(),
                  height: 79.h,
                  width: 120.w,
                  child: InkWell(
                    onTap: (){},
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(MyIcons.message,size: 40,),

                      ],
                    ),

                  ),
                ),
                Container(
                  //alignment: Alignment.center,
                  //decoration: ButtonStyle(),
                  height: 100.h,
                  width: 120.w,
                  child: InkWell(
                    onTap: (){},
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(MyIcons.like_1,size: 42,),

                      ],
                    ),
                  ),
                ),
                Container(
                  //alignment: Alignment.center,
                  height: 100.h,
                  width: 120.w,
                 // decoration: ButtonStyle(),
                  child: InkWell(
                    onTap: (){

                    },
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(MyIcons.loudspeaker,size: 34,),

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
  );
}
