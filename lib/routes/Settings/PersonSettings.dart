import 'package:flutter/material.dart';
import 'package:test_fist/widgets/SettingButton.dart';

class PersonSettings extends StatefulWidget {
  @override
  State<PersonSettings> createState() => _PersonSettingsState();
}

class _PersonSettingsState extends State<PersonSettings> {

  void _onProfilePressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 90),
            child: Text('个人信息更改',style: TextStyle(
              fontWeight: FontWeight.bold
              ),
            )
        ),
        //leading: BackButton(), // 返回
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Body(context),
      ),
    );
  }

  Widget Body(BuildContext context)
  {
    return Column(
      children: [
        //---------------------个人信息---------------------
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
            ),
            child: Column(
              children: [
                //buildButton('头像', _onProfilePressed),
                PreButton(_onProfilePressed),
                spearate(),
                buildButton('用户名', _onProfilePressed),
                spearate(),
                buildButton('社团账户', _onProfilePressed),
                spearate(),
                buildButton('密码更改', _onProfilePressed),
                spearate(),
                buildButton('更换头像框', _onProfilePressed),
              ],
            ),
          ),
        ),
        //-------------------------------------------------
        //----------------------电话邮箱--------------------
        Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
            ),
            child: Column(
              children: [
                //buildButton('电话', _onProfilePressed),
                PhoneEmailButton("电话", _onProfilePressed, Icon(Icons.phone)),
                spearate(),
                //buildButton('邮箱', _onProfilePressed),
                PhoneEmailButton("邮箱", _onProfilePressed, Icon(Icons.email_outlined)),
              ],
            ),
          ),
        ),
        //--------------------------------------------------
        //--------------------注销账号------------------------
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white
          ),
          child: Column(
            children: [
              buildButton('注销账号', _onProfilePressed),
            ],
          ),
        )
      ],
    );
  }


}


