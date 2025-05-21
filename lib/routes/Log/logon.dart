import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_fist/models/dio/getNet.dart';

//注册页面
class LogonRoute extends StatefulWidget {
  const LogonRoute({super.key});

  @override
  State<LogonRoute> createState() => _LogonRouteState();
}

class _LogonRouteState extends State<LogonRoute> {
  TextEditingController _nameController = TextEditingController();//昵称
  TextEditingController _StudentIDController = TextEditingController();//学号
  TextEditingController _pwdController = TextEditingController();//密码
  bool pwdShow = false;
  GlobalKey _fromKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("注册"),),
      body: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Form(
            key: _fromKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    autofocus: _nameAutoFocus,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "昵称",
                    ),
                    validator: (va){
                      return va==null||va.trim().isNotEmpty?null:"昵称不能为空";
                    }),
                  TextFormField(
                    controller: _StudentIDController,
                    autofocus: !_nameAutoFocus,
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
                    autofocus: !_nameAutoFocus,
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
                      padding: EdgeInsets.only(top: 25.h),
                      child: ConstrainedBox(
                          constraints: BoxConstraints.expand(height: 55.0.h),
                          child: ElevatedButton(
                              onPressed: ()async{
                                final form = _fromKey.currentState as FormState?;
                                if(form!=null&&form.validate())
                                  {
                                    try{
                                      await GetNet().register(
                                          school_number: int.tryParse(_StudentIDController.text.trim())!, name: _nameController.text.trim(), password: _pwdController.text.trim()
                                      );
                                    }catch(e){
                                      print(e);
                                    }
                                    Navigator.pop(context);
                                  }else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("请完整填写内容"))
                                  );
                                }

                              },
                              child: Text("注册", style: TextStyle(fontSize: 18.sp))),),
                  )
                ],
              )
          ),
      ),
    );
  }
}


