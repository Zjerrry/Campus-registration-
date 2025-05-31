import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_fist/models/dio/getNet.dart';
import 'package:test_fist/main.dart';
import 'package:haptic_feedback/haptic_feedback.dart';

//注册页面
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _nameController = TextEditingController();//昵称
  TextEditingController _StudentIDController = TextEditingController();//学号
  TextEditingController _pwdController = TextEditingController();//密码
  bool pwdShow = false;
  GlobalKey _fromKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;
  @override
  void dispose() {
    _nameController.dispose();
    _StudentIDController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("注册"),),
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
                  validator: (va) {
                    return va == null || va.trim().isEmpty ? "昵称不能为空" : null;
                  },
                ),

                TextFormField(
                  controller: _StudentIDController,
                  autofocus: !_nameAutoFocus,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "学号",
                  ),
                  validator: (va) {
                    return va == null || va.trim().isEmpty ? "学号不能为空" : null;
                  },
                ),

                TextFormField(
                  controller: _pwdController,
                  autofocus: !_nameAutoFocus,
                  decoration: InputDecoration(
                    labelText: "密码",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                      icon: Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),
                  obscureText: !pwdShow,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '密码不能为空';
                    }
                    if (value.length < 6) {
                      return '密码不能小于6位';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.h),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55.0.h),
                    child: ElevatedButton(
                        onPressed: ()async{
                          final can = await Haptics.canVibrate();
                          if (!can) return;
                          final form = _fromKey.currentState as FormState?;
                          if(form!=null&&form.validate()) {
                            try{
                              final listOfUser = await GetNet().login();
                              if(!checkStudentID(listOfUser, int.tryParse(_StudentIDController.text.trim())!)){
                                await Haptics.vibrate(HapticsType.error).then((onValue){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("学号已存在")));
                                });
                              }
                              else{
                                await GetNet().register(
                                    school_number: int.tryParse(_StudentIDController.text.trim())!,
                                    name: _nameController.text.trim(),
                                    password: _pwdController.text.trim().toString()
                                );
                              }
                            }catch(e){
                              print('--------------');
                              print(e);
                            }
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context){return const MyApp();}),
                                    (route)=>false
                            );
                          }
                          else {
                            await Haptics.vibrate(HapticsType.error).then((onValue){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("请填写完整内容")));
                            });
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

bool checkStudentID(List<Map<String,dynamic>> listOfUser,int studentID)
{
  for(Map<String,dynamic> user in listOfUser)
  {
    if(studentID == user['school_number']) return false;
  }
  return true;
}


