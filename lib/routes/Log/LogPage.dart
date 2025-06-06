import 'package:flutter/material.dart';
import 'login.dart';
import 'Register.dart';
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
            height: 70.h,
          ),
          Container(
            height: 100.h,
            alignment: AlignmentDirectional.bottomCenter,
            child: Row(
              children: [
                SizedBox(
                  width: 40.w,
                ),
                Text("Welcome",
                style: TextStyle(fontSize: 50.sp,
                    fontWeight:FontWeight.w600),),
              ],
            ),
          ),
          Container(
            height: 350.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150.w,
                height: 70.h,
                child: ElevatedButton(
                    onPressed: ()
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return const Login();
                          })
                      );
                    },
                    style: ButtonStyle(
                        shadowColor: WidgetStateProperty.all(Colors.transparent)
                    ),
                    child:  Text("登录", style: TextStyle(fontSize: 20.sp),)),
              ),
               SizedBox(
                width: 50.w,//后续根据屏幕尺寸修改
              ),
              SizedBox(
                width: 150.w,
                height: 70.h,
                child: ElevatedButton(
                    onPressed:  ()
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return const Register();
                          })
                      );

                    },
                  style: ButtonStyle(
                      shadowColor: WidgetStateProperty.all(Colors.transparent)
                  ),
                    child:  Text("注册",
                      style: TextStyle(fontSize: 20.sp,),),
                ),
              )
            ],
          ),
        ],
      )
    );

  }
}
