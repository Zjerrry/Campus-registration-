import 'dart:collection';
import 'dart:convert';
import 'package:test_fist/models/dio/getNet.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalInformation{
  //========================单例模式,确保唯一实例==========================
  static final GlobalInformation _instance = GlobalInformation._internal();
  factory GlobalInformation() => _instance;
  GlobalInformation._internal();

  //================================================================

  //---- 登录信息 ----
  Map<String,dynamic> _userInformation = {
    'id':0,
    'name':'',
    'school_number':0,
  };

  bool _hasLogin = false;
  bool get hasLogin => _hasLogin;

  void loadUser(int id,String name,int schoolNumber)
  {
    _userInformation['id'] = id;
    _userInformation['name'] = name;
    _userInformation['school_number'] = schoolNumber;
    _hasLogin = true;
    _saveLogin();
  }

  void clearUser()
  {
    _hasLogin = false;
    _userInformation = {
      'id':0,
      'name':'',
      'school_number':0,
    };
    _saveLogin();
  }

 Map<String,dynamic> get userInformation => _userInformation;

 //======================我收藏的社团==================================
  List<Map<String,dynamic>> _collectedClubs = [];
  List<Map<String,dynamic>> get collectedClubs => UnmodifiableListView(_collectedClubs);

  //----------------------获取只读------------------------------

  void addCollectedClub(Map<String,dynamic> club)
  {
    if(!_collectedClubs.contains(club))
      {
        _collectedClubs.add(club);
        _saveToPrefs();
      }
  }
  //--------------添加社团到收藏社团-----------------------------------

  void removeCollectedClub(Map<String,dynamic> club)
  {
    _collectedClubs.remove(club);
    _saveToPrefs();
  }
  //-------------------删除社团从收藏社团-------------------------------

  //=======================================================


 //=================所有社团=================================
 static List<Map<String,dynamic>> listOfClub = [];
  //===========================================================


 //=======================发布活动的草稿==========================
 final Map<String,dynamic> editingDraft = {
   'title':'',
   'place':'',
   'start_time':null,
   'end_time':null,
   'content':'',
 };
 //---------------------储存草稿字典---------------------------

  String get draftTitle =>editingDraft['title'];
  String get draftPlace =>editingDraft['place'];
  String get draftContent =>editingDraft['content'];
  DateTime? get draftStartTime => editingDraft['start_time'];
  DateTime? get draftEndTime => editingDraft['end_time'];
  //--------------------------------------------------------

  void updateDraft(String key,dynamic value)
  {
    print("--------------------------------");
    if(editingDraft.containsKey(key))
      {
        editingDraft[key] = value;
        print("===================");
        print("$key:$value");
        _saveToPrefs();
      }
  }
  //-----------------------草稿更新------------------------------

  void clearDraft()
  {
    editingDraft.clear();
  }
  //----------------------清空草稿-------------------------------


  //======================校区=================================
  int _school = 0;//0:双校区 1:卫津路 2:北洋园
  int get school =>_school;

  set school(int value){
    _school = value.clamp(0, 2);
    _saveToPrefs();
  }
  //-----------------校区设置--------------------------------------
  //==============================================================


 //===================关联的社团=====================================
  List<Map<String,dynamic>> _linkingClubs = [];
  List<Map<String,dynamic>> get linkingClubs => UnmodifiableListView(_linkingClubs);

  //----------------添加关联列表-----------------------------------
  void addLinkingClub(Map<String,dynamic> club)
  {
    if(!_linkingClubs.contains(club))
    {
      _linkingClubs.add(club);
      _saveToPrefs();
    }
  }

  //---------------删除关联列表--------------------------------
  void removeLinkingClub(Map<String,dynamic> club)
  {
    _linkingClubs.remove(club);
    _saveToPrefs();
  }

  //-------------清空关联列表--------------------------------
  void cleanLinkingClub()
  {
    _linkingClubs.clear();
    _saveToPrefs();
  }

//==================================================================

//================ 持久化操作 ================

  static void _saveToPrefs() => Global.saveAllData();
  static void _saveLogin() => Global.saveLogData();

  //==========================================

//=============== 初始化数据 ================

  void loadFromPrefs(Map<String, dynamic> data) async {
    print('---- 1 ----');
    _school = data['school'] ?? 0;
    editingDraft.addAll(data['editingDraft'] ?? {});
    listOfClub = await GetNet().fetchListOfClub();
    print('---- 2 ----');
    final collectedStr = data['collectedClubs'];
    if (collectedStr is String && collectedStr.isNotEmpty) {
      _collectedClubs = List<Map<String, dynamic>>.from(jsonDecode(collectedStr));
    } else {
      _collectedClubs = [];
    }

    final linkingStr = data['linkingClubs'];
    if (linkingStr is String && linkingStr.isNotEmpty) {
      _linkingClubs = List<Map<String, dynamic>>.from(jsonDecode(linkingStr));
    } else {
      _linkingClubs = [];
    }
    print('---- 3 ----');
    print('---- load complete ----');
  }

  void loginFromPrefs(Map<String,dynamic> user)
  {
    final log = user['hasLogin'];
    if(log == null){
      _hasLogin = false;
    }
    else {
      _hasLogin = log;
    }
    print('-------------$_hasLogin---------------');
    final information = user['user'];
    if(information is String && information.isNotEmpty) {
        _userInformation = jsonDecode(information);
      }
    else {
      _userInformation = {
        'id':0,
        'name':'',
        'school_number':0,
      };
    }
    print('--------------$_userInformation----------------');
  }

}

//======================持久化状态管理=======================
class Global{

  static late SharedPreferences _prefs;//创建缓存对象

  //初始化全局信息
  static Future<void> init() async
  {
    WidgetsFlutterBinding.ensureInitialized();//初始化

    _prefs = await SharedPreferences.getInstance();
    //-------------设置持久化数据--------------------------------

    //---- 加载用户信息 ----
    GlobalInformation().loginFromPrefs({
      'hasLogin':_prefs.getBool('hasLogin'),
      'user':_prefs.getString('user')
    });

    //===================加载数据================================
    GlobalInformation().loadFromPrefs({
      'collectedClubs':_prefs.getString('collected_list'),
      'linkingClubs':_prefs.getString('link_list'),
      'school':_prefs.getInt('school'),
      'editingDraft':_parseDraftData(_prefs.getString('editing_drafts')),
    });

  }

  //------------------ 解析草稿json文件 ---------------------
  static Map<String, dynamic> _parseDraftData(String? jsonString) {
    final data = jsonDecode(jsonString ?? '{}') as Map<String, dynamic>;

    return {
      'title': data['title'] ?? '',
      'place': data['place'] ?? '',
      'start_time': _safeParseDate(data['start_time']),
      'end_time': _safeParseDate(data['end_time']),
      'content': data['content'] ?? '',
    };
  }

  static DateTime? _safeParseDate(dynamic value) {
    if (value is String && value.trim().isNotEmpty) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        print('Date parse error: $e');
      }
    }
    return null;
  }

  //==========================保存数据============================

  static void saveAllData()
  {
    final collectClubs = jsonEncode(GlobalInformation().collectedClubs);
    _prefs.setString("collected_list",collectClubs);
    final linkClubs = jsonEncode(GlobalInformation().linkingClubs);
    _prefs.setString("link_list", linkClubs);

    _prefs.setInt("school", GlobalInformation().school);

    final draft = GlobalInformation().editingDraft;
    final draftJson = jsonEncode({
      'title':draft['title'] ?? '',
      'place':draft['place'] ?? '',
      'start_time':draft['start_time']?.toIso8601String() ?? '',
      'end_time':draft['end_time']?.toIso8601String() ?? '',
      'content':draft['content'] ?? ''
    });

    _prefs.setString('editing_drafts',draftJson);
  }

  static void saveLogData()
  {
    final userInformation = jsonEncode(GlobalInformation()._userInformation);
    _prefs.setString('user', userInformation);
    _prefs.setBool('hasLogin', GlobalInformation()._hasLogin);

  }

}

