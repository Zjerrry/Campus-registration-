import 'package:flutter/material.dart';
import 'login.dart';
import 'logon.dart';

class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 70,//后续根据屏幕尺寸修改
          ),
          Container(
            height: 100,//后续根据屏幕尺寸修改
            alignment: AlignmentDirectional.bottomCenter,
            child: const Row(
              children: [
                SizedBox(
                  width: 40,//后续根据屏幕尺寸修改
                ),
                Text("Welcome",
                style: TextStyle(fontSize: 50,//后续根据屏幕尺寸修改
                    fontWeight:FontWeight.w600),),
              ],
            ),
          ),
          Container(
            height: 350,//后续根据屏幕尺寸修改
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,//后续根据屏幕尺寸修改
                height: 70,//后续根据屏幕尺寸修改
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
                    child: const Text("登录",
                      style: TextStyle(fontSize: 20),)),
              ),
              const SizedBox(
                width: 50,//后续根据屏幕尺寸修改
              ),
              SizedBox(
                width: 150,//后续根据屏幕尺寸修改
                height: 70,//后续根据屏幕尺寸修改
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
                    child: const Text("注册",
                      style: TextStyle(fontSize: 20,),)),
              )
            ],
          ),
        ],
      )
    );

  }
}
