import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_fist/commons/Global.dart';
import 'package:test_fist/main.dart';
import 'package:test_fist/models/dio/getNet.dart';
import 'package:test_fist/routes/HomePage.dart';

//注册页面
class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _StudentIDController = TextEditingController();//学号
  TextEditingController _pwdController = TextEditingController();//密码
  bool pwdShow = false;
  GlobalKey _fromKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("登录"),),
      body: Padding(
        padding:  EdgeInsets.all(16.0.w),
        child: Form(
            key: _fromKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _StudentIDController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "学号",
                  ),
                  validator: (va){
                    return va==null||va.trim().isNotEmpty?null:"学号不能为空";
                  },
                ),
                TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      suffixIcon: IconButton(
                          onPressed: ()
                          {
                            setState(() {
                              pwdShow = !pwdShow;
                            });
                          },

                          icon: Icon(pwdShow?Icons.visibility_off:Icons.visibility))
                  ),
                  obscureText: !pwdShow,
                  validator: (va){
                    return va==null||va.trim().isNotEmpty?null:"密码不能为空";
                  },
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 25.h),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55.0.h),
                    child: ElevatedButton(
                        onPressed: () async{
                          final form = _fromKey.currentState as FormState?;
                          if(form!=null&&form.validate())
                          {
                            try{
                              int _schoolnumber = int.tryParse(_StudentIDController.text.trim())!;
                              String _password = _pwdController.text.trim();
                              final listOfUser = await GetNet().login();
                              if(!loginCheck(listOfUser, _schoolnumber, _password))
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("学号或密码错误"))
                                  );
                                }
                              else{
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context){
                                      return const MyApp();
                                    })
                                );
                              }
                            }catch(e){
                              print(e);
                            }
                          }else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("请完整填写内容"))
                            );
                          }

                        },
                        child: Text("登录", style: TextStyle(fontSize: 18.sp))),),
                )
              ],
            )
        ),
      ),
    );
  }
}

bool loginCheck(List<Map<String,dynamic>> listOfUser,int schoolNumber,String password)
{
  for ( Map<String,dynamic> item in listOfUser) {
    if(item['school_number'] != schoolNumber ) continue;
    if(item['password'] != password ) return false;
    GlobalInformation().loadUser(item['id'], item['name'], item['school_number']);
    return true;
  }
  return false;
}