import 'package:flutter/material.dart';
class ClubMainPage extends StatefulWidget {
  const ClubMainPage({super.key,required this.clubname});

  final String clubname;
  @override
  State<ClubMainPage> createState() => _ClubMainPageState();
}

class _ClubMainPageState extends State<ClubMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: CustomScrollView(
        slivers: [
          //社团信息
          Club_Information(context,widget.clubname),
          SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context,index)
              {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text("$index"),
                    onTap: (){},
                  ),
                );
              })
          )
        ],
      ),
    );
  }
}

Widget Club_Information(context,ClubName)
{
  return SliverToBoxAdapter(
    child: Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.person,size: 100,),//社团头像
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(ClubName,style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25
                      ),),//社团名称
                      Text("类型:  育人实践基地")//社团类型
                    ],//！！！！！！！！！！！会溢出屏幕！！！！！！！！！
                  ),
                ),
                Icon(Icons.favorite_border,size: 30,) //是否关注该社团
              ],),
          ),

          ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: double.infinity,
                minHeight: 100
              ),
            child: const Padding(
              padding: const EdgeInsets.only(left: 40.0,right: 40),
              child:  Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text("社团简介:",style: TextStyle(
                        fontWeight: FontWeight.w700)),
                  ),
                  Expanded(
                    child: Text(
                        "该社团是XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
                    ),
                  )

                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
            child: Text("活动一览",style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                color: Colors.grey
            ),),
          )
        ],
      ),
    ),
  );
}