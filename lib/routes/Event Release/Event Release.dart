import 'package:flutter/material.dart';
import 'package:test_fist/routes/ViewClub/ClubMainPage.dart';
import 'addLinkClub.dart';
import 'package:test_fist/widgets/ImagePicker.dart';
import 'package:test_fist/commons/Global.dart';


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
  TextEditingController _timeController =TextEditingController();


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
    _timeController = TextEditingController(text: draft['time']);
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
            fontSize: 24,
            fontWeight: FontWeight.w700
          ),),
        ),
        body:CustomScrollView(
          slivers: [
            //======================= 活动信息的填写 ======================================
          SliverToBoxAdapter(
              child: Padding(
            padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          //============================输入活动名称=====================
                  TextFormField(
                    controller: _titleController,
                    style: const TextStyle(fontSize: 20),
                    decoration:const  InputDecoration(
                        hintText: "添加标题",
                        hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                        )
                    ),
                    validator: (value)=>
                    value == null||value.trim().isNotEmpty?null:"活动名称不能为空",

                    onChanged: (value)=> GlobalInformation().updateDraft('title', value)
                  ),
                  Container(
                    width: 206,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //========================活动时间====================================
                        TextFormField(
                          controller: _timeController,
                            style: const TextStyle(fontSize: 12),
                          decoration:const  InputDecoration(
                              hintText: "添加活动时间",
                              hintStyle: TextStyle(fontSize: 12),
                              border: InputBorder.none,
                              prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 10),
                                child: Icon(Icons.access_time_rounded,size: 24,),
                              )
                          ),
                            onChanged: (value)=> GlobalInformation().updateDraft('time', value)
                        ),
                        //===========================活动地点 ==============================
                        TextFormField(
                          controller: _placeController,
                            style: const TextStyle(fontSize: 12),
                          decoration:const  InputDecoration(
                              hintText: "添加活动地点",
                              hintStyle: TextStyle(fontSize: 12),
                              border: InputBorder.none,
                              prefixIcon: Padding(padding: EdgeInsets.symmetric(vertical: 10),
                                child: Icon(Icons.location_on_outlined,size: 24,),
                              )
                          ),
                            onChanged: (value)=> GlobalInformation().updateDraft('place', value)
                        ),
                        //================================关联社团============================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(left: 12),
                              child: Icon(Icons.add,size: 24,),
                            ),
                            TextButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => addLinkClub(),
                                  ),
                                );
                                setState(() {});
                              },
                              child: const Text("添加关联社团",
                                style: TextStyle(fontSize: 12),),
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
            SliverPadding(padding: EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[200]
                  ),
                  child:Padding(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Column(
                      children: [
                        //-------------内容填写-----------
                        TextFormField(
                          controller: _contentController,
                          maxLines: null,
                          minLines: 9,
                            style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                              hintText: "请添加正文",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16
                              ),
                              border: InputBorder.none
                          ),
                            onChanged: (value)=> GlobalInformation().updateDraft('content', value)
                        ),
                        //--------------------------------
                        //-----------图片上传--------------
                        const Padding(padding:EdgeInsets.only(top: 20),
                          child: ImagePicker(
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
                                onPressed: (){},
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
                padding: const EdgeInsets.symmetric(horizontal: 5),
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

    ) ;
  }
}



Widget _buildClubTag(BuildContext context,int index)
{
  return TextButton(
      style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        //side: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
            ),
        ),
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder: (context)=> ClubMainPage(
            ClubName: GlobalInformation().linkingClubs[index],
          ))
       );
      },
      child: Text(
                "#${GlobalInformation().linkingClubs[index]}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14
                ),
    ),
  );
}
