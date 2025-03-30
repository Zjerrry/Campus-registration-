import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: Text('通知中心', style: TextStyle(fontSize: 18.sp)),
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
                  height: 100.h,
                  width: 120.w,
                  child: InkWell(
                    onTap: (){},
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.message,color: Colors.black,size: 40,),

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
                        const Icon(Icons.thumb_up_alt_outlined,color: Colors.black,size: 40,),

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
                        const Icon(Icons.campaign,color: Colors.black,size: 40,),

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
