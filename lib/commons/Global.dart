import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global{
  static late SharedPreferences _prefs;//创建缓存对象

  //初始化全局信息
  static Future init() async
  {
    WidgetsFlutterBinding.ensureInitialized();//初始化
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");//获取用户信息
    if(_profile != null)
      {
        try{
          //profile = Profile.fromJson(jsonDecode(_profile));
        } catch(err){
          print(err);
        }
      }
    else{
      //未登陆过，初次登录
    }
    //初始化网络请求

  }
  static saveProfile()
  {
    //_prefs.setString("profile", jsonEncode(profile.toJson()));
  }
}