import 'package:flutter/material.dart';
import 'package:test_fist/routes/Settings/ClubSettings.dart';
import 'package:test_fist/commons/Global.dart';

class ClubMainPage extends StatefulWidget {
  const ClubMainPage({super.key,required this.ClubName});

  final String ClubName;
  @override
  State<ClubMainPage> createState() => _ClubMainPageState();
}

class _ClubMainPageState extends State<ClubMainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration:  BoxDecoration(
                  color: Colors.grey[400],
                ),
                child: const Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Text("社团主页"),
                ),
              ),
            ],
          ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClubSettings(),
                  ),
                );
              },
              icon: const Icon(Icons.settings,size: 40,)
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          //------------------------------------------------------------------------
          //社团信息
          ClubInformation(clubname: widget.ClubName,),

          //-------------------------社团活动----------------------------------------
          SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context,index)
              {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text("$index"),
                    onTap: (){},
                  ),
                );
              },
                childCount: 10
              )
          )
        ],
      ),
    );
  }
}


class ClubInformation extends StatefulWidget {
  const ClubInformation({super.key,required this.clubname});
  final String clubname;

  @override
  State<ClubInformation> createState() => _ClubInformationState();
}

class _ClubInformationState extends State<ClubInformation> {
  //bool is_collected = false;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: [
            //----------------------------------------------------------------------------
            //社团信息部分
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey

                      ),
                    ),
                  ),
                  //社团头像
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.clubname,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 25
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),//社团名称
                        Text("类型:  育人实践基地",style: TextStyle(
                            color: Colors.grey[600],fontSize: 17
                        ),)//社团类型
                      ],//会溢出屏幕
                    ),
                  ),
                  IconButton(icon:Icon(GlobalInformation().collectedClubs.contains(widget.clubname)
                      ?Icons.star:Icons.star_border,size: 30,
                    color:GlobalInformation().collectedClubs.contains(widget.clubname)
                        ?Colors.yellow[700]:Colors.black,),
                      onPressed: (){
                          if(!GlobalInformation().collectedClubs.contains(widget.clubname)) {
                            GlobalInformation().addCollectedClub(widget.clubname);
                          }
                          else{
                            GlobalInformation().removeCollectedClub(widget.clubname);
                          }
                        setState(() {});
                      }
                  ) //是否关注该社团
                ],),
            ),
            //-------------------------------------------------------------
            //社团简介部分
            //---------------------------------------------------------------
            ConstrainedBox(
              constraints:const  BoxConstraints(
                  minHeight: 100
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 20,top: 3),
                      child: Text("社团简介:",style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontSize: 16
                      )
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "该社团是XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
                        style: TextStyle(
                            color: Colors.grey[600],
                            height: 1.5,
                            fontSize: 14
                        ),
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
}

