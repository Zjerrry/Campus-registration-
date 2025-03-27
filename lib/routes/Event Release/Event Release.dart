import 'package:flutter/material.dart';
import 'package:test_fist/routes/ViewClub/ClubMainPage.dart';
import 'addLinkClub.dart';
import 'package:test_fist/widgets/ImagePicker.dart';
Set<String> addedClub = {};
List<String> addClubList = [];

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
  List<String> School = ["双校区","卫津路","北洋园"];
  int SchoolIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title:  Text("发布新活动",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700
          ),),
        ),
        body:CustomScrollView(
          slivers: [
            //活动的填写
            Body(context),
            //--------------图片上传---------------------

            const SliverPadding(padding: EdgeInsets.only(left: 100,bottom: 20),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                      ImagePicker(
                        child: Icon(Icons.photo_outlined),
                      ),
                  ],
                )
              ),
            ),

            //--------------图片上传---------------------

            //内容操作区
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    //校区选择和发送
                    Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //校区选择
                        TextButton.icon(
                          onPressed: ()
                          {//点击校区更换
                          setState((){{if(SchoolIndex == 2) {SchoolIndex = 0;}
                          else {SchoolIndex +=1;}}});
                                  },
                          label: Text(
                            School[SchoolIndex],
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

                    const SizedBox(
                      height: 6,
                    ),

                    //关联社区选择
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context)=> addLinkClub())
                              );
                              if(result != null)
                              {
                                setState(() {
                                  addClubList = List.from(result);
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300]
                            ),
                            child: const Text("添加关联社团",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                          ),
                        ],
                      ),

                  ],
                ),
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
                      childCount: addClubList.length
                  )
              ),
            )
          ],
        )

    ) ;
  }
}



Widget Body(BuildContext context)
{
  TextEditingController _title_controller =TextEditingController();
  TextEditingController _place_controller =TextEditingController();
  TextEditingController _time_controller =TextEditingController();
  TextEditingController _content_controller = TextEditingController();

  return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            //输入活动名称
            TextFormField(
              controller: _title_controller,
              decoration:const  InputDecoration(
                  hintText: "添加标题",
                  hintStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                  )
              ),
              validator: (value){
                return value == null||value.trim().isNotEmpty?null:"活动名称不能为空";
              },
            ),
            TextFormField(
              controller: _place_controller,
              decoration:const  InputDecoration(
                  hintText: "添加活动地点",
              ),
            ),
            TextFormField(
              controller: _time_controller,
              decoration:const  InputDecoration(
                  hintText: "添加活动时间"
              ),
            ),
            //活动地点
            TextFormField(
              controller: _content_controller,
              maxLines: null,
              minLines: 15,
              decoration: const InputDecoration(
                  hintText: "请添加正文",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 25
                  ),
                  border: InputBorder.none
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      )
  );
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
            ClubName: addClubList[index],
          ))
       );
      },
      child: Text(
                "#${addClubList[index]}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 14
                ),
    ),
  );
}
