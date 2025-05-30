import 'package:flutter/material.dart';
import 'package:test_fist/widgets/SettingButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_fist/widgets/my_icons_icons.dart';

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
        title: const Center(
            child: Text('个人信息更改',style: TextStyle(
              fontWeight: FontWeight.bold
              ),
            )
        ),
        //leading: BackButton(), // 返回
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20.w),
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
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
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
          padding: EdgeInsets.only(bottom: 15.h),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: Colors.white
            ),
            child: Column(
              children: [
                //buildButton('电话', _onProfilePressed),
                PhoneEmailButton("电话", _onProfilePressed, Icon(MyIcons.call,size: 24,)),
                spearate(),
                //buildButton('邮箱', _onProfilePressed),
                PhoneEmailButton("邮箱", _onProfilePressed, Icon(Icons.mail_outline,size: 24,)),
              ],
            ),
          ),
        ),
        //--------------------------------------------------
        //--------------------注销账号------------------------
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
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


