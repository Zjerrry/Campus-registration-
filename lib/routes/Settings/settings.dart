import 'package:flutter/material.dart';
class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _onSettingsPressed() {

  }

  void _onProfilePressed() {
    /*
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSettingsPage(),
      ),
    );*/
  }

  void _onAboutPressed() {

  }

  void _onLogoutPressed() {

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
        leading: BackButton(), // 返回
      ),

      body:Column(
        children: [
          _buildButton('设置', Icons.settings, _onSettingsPressed),
          _buildButton('个人信息', Icons.person, _onProfilePressed),
          _buildButton('关于', Icons.info, _onAboutPressed),
          _buildButton('登出', Icons.exit_to_app, _onLogoutPressed),
        ],
      ),
    );
  }
  Widget _buildButton(String title, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.blueAccent),
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



/*class ProfileSettingsPage extends StatefulWidget {
  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPage();
}

class _ProfileSettingsPage extends State<ProfileSettingsPage> {

}*/

