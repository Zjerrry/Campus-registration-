import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _fromKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    autofocus: _nameAutoFocus,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "昵称",
                    ),
                    validator: (va){
                      return va==null||va.trim().isNotEmpty?null:"昵称不能为空";
                    }),
                  TextFormField(
                    controller: _StudentIDController,
                    autofocus: !_nameAutoFocus,
                    decoration: InputDecoration(
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
                      padding: const EdgeInsets.only(top: 25),
                      child: ConstrainedBox(
                          constraints: BoxConstraints.expand(height: 55.0),
                          child: ElevatedButton(
                              onPressed: _onLogon,
                              child: Text("注册")),),
                  )
                ],
              )
          ),
      ),
    );
  }
}

void _onLogon()
{

}
