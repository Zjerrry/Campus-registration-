import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalInformation{
  //========================单例模式,确保唯一实例==========================
  static final GlobalInformation _instance = GlobalInformation._internal();
  factory GlobalInformation() => _instance;
  GlobalInformation._internal();

  //================================================================


 //======================我收藏的社团==================================
  List<String> _collectedClubs = [];
  List<String> get collectedClubs => UnmodifiableListView(_collectedClubs);

  //----------------------获取只读------------------------------

  void addCollectedClub(String club)
  {
    if(!_collectedClubs.contains(club))
      {
        _collectedClubs.add(club);
        _saveToPrefs();
      }
  }
  //--------------添加社团到收藏社团-----------------------------------

  void removeCollectedClub(String club)
  {
    _collectedClubs.remove(club);
    _saveToPrefs();
  }
  //-------------------删除社团从收藏社团-------------------------------

  //=======================================================


 //=================所有社团=================================
 static List<String> AllClub = [
   "天外天工作室",
   "青年志愿者协会XXXXXXXXXXXXXXXXXXX",
   "学生会",
   "天津大学校园建设发展协会（北洋讲解队）",
   "abcdef",
   "abc",
   "北洋之声",
   "北洋合唱团",
   "北洋艺术团"
 ];
  //===========================================================


 //=======================发布活动的草稿==========================
 final Map<String,dynamic> editingDraft = {
   'title':'',
   'time':'',
   'place':'',
   'content':'',
 };
 //---------------------储存草稿字典---------------------------

  String get draftTitle =>editingDraft['title'];
  String get draftTime =>editingDraft['time'];
  String get draftPlace =>editingDraft['place'];
  String get draftContent =>editingDraft['content'];
  //--------------------------------------------------------

  void updateDraft(String key,dynamic value)
  {
    if(editingDraft.containsKey(key))
      {
        editingDraft[key] = value;
        _saveToPrefs();
      }
  }
  //-----------------------草稿更新------------------------------


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
  List<String> _linkingClubs = [];
  List<String> get linkingClubs => UnmodifiableListView(_linkingClubs);

  //----------------获取只读关联列表-----------------------------------
  void addLinkingClub(String club)
  {
    if(!_linkingClubs.contains(club))
    {
      _linkingClubs.add(club);
      _saveToPrefs();
    }
  }

  //---------------添加关联列表--------------------------------
  void removeLinkingClub(String club)
  {
    _linkingClubs.remove(club);
    _saveToPrefs();
  }

  //-------------删除关联列表--------------------------------

//==================================================================

//================ 持久化操作 ================

static void _saveToPrefs() => Global.saveAllData();

  //==========================================

//=============== 初始化数据 ================

void loadFromPrefs(Map<String,dynamic> data)
  {
    _collectedClubs = List<String>.from(data['collectedClubs'] ?? []);
    _linkingClubs = List<String>.from(data['linkingClubs'] ?? []);
    _school = data['school'] ?? 0;
    editingDraft.addAll(Map<String,dynamic>.from(data['editingDraft'] ?? {}));
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

    //===================加载数据================================
    //------------  会卡住？？？  -----------------
    // GlobalInformation().loadFromPrefs({
    //   'collectedClub':_prefs.getStringList('collect_list'),
    //   'linkingClubs':_prefs.getStringList('linking_list'),
    //   'school':_prefs.getInt('school'),
    //   'editingDraft':_prefs.getStringList('editing_draft'),
    // });

    //===========================================================
  }

  //==========================保存数据============================

  static void saveAllData()
  {
    _prefs.setStringList("collect_list", GlobalInformation().collectedClubs);

    _prefs.setStringList("linking_list", GlobalInformation().linkingClubs);

    _prefs.setInt("school", GlobalInformation().school);

    final draft = GlobalInformation().editingDraft;
    _prefs.setStringList(
      'editing_draft', [
      draft['title'] ?? '',
      draft['time'] ?? '',
      draft['place'] ?? '',
      draft['content'] ?? ''
      ]
    );

  }

//==================================================================


}

