import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class GetNet {
  // ---- 单例模式 ----
  static final GetNet _instance = GetNet._internal();
  factory GetNet() => _instance;
  GetNet._internal();

  static const String _url = 'https://naapoemsqvuicohvrnbe.supabase.co';
  static const String _urlKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5hYXBvZW1zcXZ1aWNvaHZybmJlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2MjA5OTEsImV4cCI6MjA2MzE5Njk5MX0.ldmYiJ1BxZ7wYVykoke1CnVAarjZck3Eyt1xjJV5tFY';

  static Future<void> init() async {
    await Supabase.initialize(
      url: _url,
      anonKey: _urlKey,
    );
  }

  SupabaseClient supaBase = Supabase.instance.client;

  //---- 获取社团名录 ----
  Future<List<Map<String, dynamic>>> fetchListOfClub() async {
    final response = await supaBase.from('List_of_Club').select();
    return List<Map<String, dynamic>>.from(response);
  }

  //---- 获取活动名录 ----
  Future<List<Map<String, dynamic>>> fetchListOfEvent() async {
    final response = await supaBase.from('List_of_Activities').select();
    return List<Map<String, dynamic>>.from(response);
  }

  //---- 发布活动数据 ----
  Future<void> insertChat({
    required int publisher_id,
    required int publisher_schoolnumber,
    required String publisher_name,
    required String title,
    required String place,
    required int school,
    required DateTime start_time,
    required DateTime end_time,
    required List link_club,
    required String content,
    required DateTime publish_time,

  }) async {
    final response = await supaBase.from('List_of_Activities').insert({
      'publisher_id': publisher_id,
      'publisher_name':publisher_name,
      'publisher_schoolnumber':publisher_schoolnumber,
      'title': title,
      'place': place,
      'start_time':jsonEncode(start_time.toIso8601String()),
      'end_time':jsonEncode(end_time.toIso8601String()),
      'content': content,
      'link_club':jsonEncode(link_club),
      'school':school,
      'publish_time':jsonEncode(publish_time.toIso8601String())
    });
    if (response.error != null) {
      throw Exception('error:${response.error!.message}');
    }
  }

  //---- 注册 ----
  Future<void> register({
    required int school_number,
    required String name,
    required String password
  }) async {
    final response = await supaBase.from('user').insert({
      'name': name,
      'password': password,
      'school_number': school_number,
    });
    if (response.error != null) {
      throw Exception('error:${response.error!.message}');
    }
  }

  //---- 登录 ----
  Future<List<Map<String, dynamic>>> login() async {
    final response = await supaBase.from('user').select();
    print(response);
    return List<Map<String, dynamic>>.from(response);
  }




}