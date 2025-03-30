import 'package:flutter/material.dart';
import 'login.dart';
import 'logon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: 70.h,//后续根据屏幕尺寸修改
          ),
          Container(
            height: 100.h,//后续根据屏幕尺寸修改
            alignment: AlignmentDirectional.bottomCenter,
            child: Row(
              children: [
                SizedBox(
                  width: 40.w,//后续根据屏幕尺寸修改
                ),
                Text("Welcome",
                style: TextStyle(fontSize: 50.sp,//后续根据屏幕尺寸修改
                    fontWeight:FontWeight.w600),),
              ],
            ),
          ),
          Container(
            height: 350.h,//后续根据屏幕尺寸修改
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150.w,//后续根据屏幕尺寸修改
                height: 70.h,//后续根据屏幕尺寸修改
                child: ElevatedButton(
                    onPressed: ()
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return const LoginRoute();
                          })
                      );
                    },
                    child:  Text("登录", style: TextStyle(fontSize: 20.sp),)),
              ),
               SizedBox(
                width: 50.w,//后续根据屏幕尺寸修改
              ),
              SizedBox(
                width: 150.w,//后续根据屏幕尺寸修改
                height: 70.h,//后续根据屏幕尺寸修改
                child: ElevatedButton(
                    onPressed:  ()
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return const LogonRoute();
                          })
                      );
                    },
                    child:  Text("注册",
                      style: TextStyle(fontSize: 20.sp,),)),
              )
            ],
          ),
        ],
      )
    );

  }
}
