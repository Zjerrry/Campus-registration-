import 'package:flutter/material.dart';
import 'addLinkClub.dart';
Set<String> addedClub = {};

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
      body:_Body() ,
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
        title: Text("发布新活动"),
      ),
      body:CustomScrollView(
        slivers: [
          Body(context),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(onPressed: (){
                  setState((){
                    {
                      if(SchoolIndex == 2)
                      {
                        SchoolIndex = 0;
                      }
                      else
                      {
                        SchoolIndex +=1;
                      }

                    }
                  });
                },
                  label: Text(School[SchoolIndex],
                    style: const TextStyle(
                        color: Colors.blue
                    ),
                  ),
                  icon: const Icon(Icons.location_on_outlined,color: Colors.blue,),
                ),
                const SizedBox(
                  width: 20,
                ),
                //发送按钮
                ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("发送",
                        style: TextStyle(
                            color: Colors.white
                        )
                    )

                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                //添加关联社团的按钮
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> addLinkClub())
                      ).then((result){
                        addedClub = result.toSet();
                      });
                    },
                    child: Text("添加关联社团",
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[350]
                  ),
                ),
                //显示关联社团
                // !!!!!!!!待完成!!!!!!!!!!
                const Row(
                  children: [

                  ],
                )
              ],
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
                labelText: "活动地点："
            ),
          ),
          TextFormField(
            controller: _time_controller,
            decoration:const  InputDecoration(
                labelText: "活动时间："
            ),
          ),
          //活动地点
          TextFormField(
            controller: _content_controller,
            maxLines: null,
            minLines: 15,
            decoration: const InputDecoration(
              // labelText: "活动内容",
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
