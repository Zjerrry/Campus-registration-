import 'package:flutter/material.dart';
import 'package:test_fist/widgets/SettingButton.dart';


class ClubSettings extends StatefulWidget {
  const ClubSettings({super.key});

  @override
  State<ClubSettings> createState() => _ClubSettingsState();
}

class _ClubSettingsState extends State<ClubSettings> {

  void _onProfilePressed() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 90),
            child: Text('社团信息更改',style: TextStyle(
                fontWeight: FontWeight.bold
            ),
            )
        ),
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
        //---------------------社团信息---------------------
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
            ),
            child: Column(
              children: [
                buildButton('社团标志', _onProfilePressed),
                spearate(),
                buildButton('社团简介', _onProfilePressed),
                spearate(),
                buildButton('社团账户', _onProfilePressed),
                spearate(),
                buildButton('管理认证账户', _onProfilePressed),
                spearate(),
                buildButton('管理活动', _onProfilePressed),
              ],
            ),
          ),
        ),
        //-------------------------------------------------
      ],
    );
  }
}
