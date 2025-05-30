import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_fist/routes/ViewClub/ClubMainPage.dart';
import 'addLinkClub.dart';
import 'package:test_fist/widgets/ImagePicker.dart';
import 'package:test_fist/commons/Global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_fist/widgets/my_icons_icons.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:test_fist/models/dio/getNet.dart';

class EventReleasePage extends StatefulWidget {
  const EventReleasePage({super.key});

  @override
  State<EventReleasePage> createState() => _EventReleasePageState();
}

class _EventReleasePageState extends State<EventReleasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:_Body(key: UniqueKey(),) ,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {

  final List<String> _school = ["双校区","卫津路","北洋园"];

  TextEditingController _contentController = TextEditingController();
  TextEditingController _titleController =TextEditingController();
  TextEditingController _placeController =TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  GlobalKey _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  // ------------初始化信息---------------------------------------
  void _initializeControllers() {
    final draft = GlobalInformation().editingDraft;
    _titleController = TextEditingController(text: draft['title']);
    _placeController = TextEditingController(text: draft['place']);
    _contentController = TextEditingController(text: draft['content']);
    startDate = draft['start_time'];
    endDate = draft['end_time'];
  }

  //-------------最终保存-----------------------------------------

  @override
  void dispose() {
    _titleController.dispose();
    _placeController.dispose();
    _contentController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("发布新活动",style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700
          ),),
        ),
        body: Form(
          key: _formKey,
            child: CustomScrollView(
              slivers: [
                //======================= 活动信息的填写 ======================================
                SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //============================输入活动名称=====================
                          TextFormField(
                              controller: _titleController,
                              style:  TextStyle(fontSize: 20.sp),
                              decoration:  InputDecoration(
                                  hintText: "添加标题",
                                  hintStyle: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  )
                              ),
                              validator: (value)=>
                              value == null||value.trim().isNotEmpty?null:"活动名称不能为空",

                              onChanged: (value)=> GlobalInformation().updateDraft('title', value)
                          ),
                          SizedBox(
                            width: 206.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //========================活动时间====================================
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 12.w),
                                      child: Icon(Icons.access_time_rounded,size: 24.sp,),
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          final selectDate = await showRangePickerDialog(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            minDate: DateTime(2021, 1, 1),
                                            maxDate: DateTime(2028, 12, 31),
                                            singelSelectedCellDecoration: BoxDecoration(
                                                color: Colors.blueAccent[100],
                                                shape: BoxShape.circle
                                            ),
                                            currentDateDecoration: BoxDecoration(
                                                border: Border.all(color: Colors.blueAccent,width: 1),
                                                shape: BoxShape.circle
                                            ),
                                          );
                                          // await Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => addEventTime(),
                                          //   ),
                                          // );
                                          if(selectDate != null)
                                          {
                                            setState(() {
                                              startDate = selectDate.start;
                                              endDate = selectDate.end;
                                            });
                                            GlobalInformation().updateDraft('start_time',startDate);
                                            GlobalInformation().updateDraft('end_time',endDate);
                                          }
                                        },
                                        child: Text(
                                          startDate != null && endDate != null ?
                                          "${startDate!.year}/${startDate!.month}/${startDate!.day}-${endDate!.year}/${endDate!.month}/${endDate!.day}"
                                              :"待确定",
                                          style: TextStyle(fontSize: 12.sp,
                                              color: Colors.blue),
                                        )
                                    ),
                                  ],

                                ),
                                //===========================活动地点 ==============================
                                TextFormField(
                                    controller: _placeController,
                                    style:  TextStyle(fontSize: 12.sp),
                                    decoration: InputDecoration(
                                        hintText: "添加活动地点",
                                        hintStyle: TextStyle(fontSize: 12.sp),
                                        border: InputBorder.none,
                                        prefixIcon: Padding(padding: EdgeInsets.only(bottom: 13.h),
                                          child: const Icon(MyIcons.location,size: 24,),
                                        )
                                    ),
                                    onChanged: (value)=> GlobalInformation().updateDraft('place', value)
                                ),
                                //================================关联社团============================
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 12.w),
                                      child: const Icon(MyIcons.category,size: 24,),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const addLinkClub(),
                                          ),
                                        );
                                        setState(() {});
                                      },
                                      child:  Text("添加关联社团",
                                        style: TextStyle(fontSize: 12.sp, color: Colors.blue),),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                //==========================活动内容填写============================
                SliverPadding(padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  sliver: SliverToBoxAdapter(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.grey[200]
                          ),
                          child:Padding(padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                            child: Column(
                              children: [
                                //-------------内容填写-----------
                                TextFormField(
                                    controller: _contentController,
                                    maxLines: null,
                                    minLines: 9,
                                    style:  TextStyle(fontSize: 16.sp),
                                    decoration:  InputDecoration(
                                        hintText: "请添加正文",
                                        hintStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16.sp
                                        ),
                                        border: InputBorder.none
                                    ),
                                    onChanged: (value)=> GlobalInformation().updateDraft('content', value)
                                ),
                                //--------------------------------
                                //-----------图片上传--------------
                                Padding(padding:EdgeInsets.only(top: 20.h),
                                  child: const ImagePicker(
                                    child: Icon(Icons.photo_outlined),
                                  ),),
                                //-------------------------------
                                //---------校区选择和发送----------
                                //校区选择和发送
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    //校区选择
                                    TextButton.icon(
                                      onPressed: ()
                                      {//点击校区更换
                                        setState((){
                                          if(GlobalInformation().school == 2)
                                          {
                                            GlobalInformation().school = 0;
                                          }
                                          else {
                                            GlobalInformation().school +=1;
                                          }
                                        });
                                      },
                                      label: Text(
                                        _school[GlobalInformation().school],
                                        style: const TextStyle(
                                            color: Colors.blue
                                        ),
                                      ),
                                      icon: const Icon(Icons.location_on_outlined,color: Colors.blue,size: 20,),
                                    ),
                                    //发送按钮
                                    ElevatedButton(
                                        onPressed: () async {
                                          final form = _formKey.currentState as FormState?;
                                          if (form != null && form.validate())
                                          {
                                            try {
                                              await GetNet().insertChat(
                                                publisher_name: GlobalInformation().userInformation['name'],
                                                publisher_schoolnumber: GlobalInformation().userInformation['school_number'],
                                                publisher_id: GlobalInformation().userInformation['id'],
                                                title: _titleController.text.trim(),
                                                place: _placeController.text.trim(),
                                                start_time: startDate??DateTime.now(),
                                                end_time: endDate??DateTime.now(),
                                                content: _contentController.text.trim(),
                                                school: GlobalInformation().school,
                                                link_club: GlobalInformation().linkingClubs,
                                                publish_time: DateTime.now()
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(content: Text("发布成功！"))
                                              );
                                            } catch (e) {
                                              print(e);
                                            }
                                            GlobalInformation().cleanLinkingClub();
                                            GlobalInformation().clearDraft();
                                            Navigator.pop(context);
                                          }
                                          else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(content: Text("请完整填写内容"))
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                        child: const Text("发送",
                                            style: TextStyle(color: Colors.white)
                                        )
                                    )
                                  ],
                                ),
                                //------------------------------
                              ],
                            ),
                          )

                      )
                  ),
                ),

                //显示关联社团
                SliverPadding(
                  padding:  EdgeInsets.symmetric(horizontal: 5.w),
                  sliver: SliverGrid(
                      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                        //mainAxisExtent: 120,
                        crossAxisCount: 4,
                        childAspectRatio: 2.2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return _buildClubTag(context, index);
                          },
                          childCount: GlobalInformation().linkingClubs.length
                      )
                  ),
                )
              ],
            )
        )

    ) ;
  }
}



Widget _buildClubTag(BuildContext context,int index)
{
  return TextButton(
      style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        //side: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
            ),
        ),
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context)=> ClubMainPage(
            club: GlobalInformation().linkingClubs[index],
          ))
       );
      },
      child: Text(
                "#${GlobalInformation().linkingClubs[index]['club_name']}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                style:  TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14.sp
                ),
    ),
  );
}
