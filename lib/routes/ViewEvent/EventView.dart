import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:test_fist/widgets/Tool.dart';
import 'package:test_fist/widgets/ClubSearch.dart';
import '../Log/LogPage.dart';

class EventView extends StatefulWidget {
  const EventView({super.key});

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  List<String> TitleTime = const ["早上好","中午好","下午好","晚上好","早点休息~"];
  String nowTime = "";
  static String SearchValue = "";
  void initState()
  {
    super.initState();
    nowTime = TitleTime[getTime().getTitleTime()];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.black,
        title: TopSearchBar(
                lable: "搜索活动",
                onSearch: (value){
                  setState(() {
                    SearchValue = value;
                    Search(SearchValue);
                  });
                },
                SearchValue: SearchValue
            ),
        actions: <Widget>[ //导航栏右侧菜单
          IconButton(icon: Icon(Icons.login,color: Colors.blue,), onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context){
                  return const LogPage();
                })
            );
          }),
        ],

      ),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context,bool inner){
            return [
              SliverToBoxAdapter(
                child:Padding(padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue[50]
                    ),
                    child: Padding(padding: EdgeInsets.only(top: 8,left: 15),
                      child: Text("${nowTime},XXX",
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ),
                )

              ),
              TopImageSliver(context)
            ];
          },
          body: EventViewList(context),
      ),
    );
  }
}
//顶部滚动显示
Widget TopImageSliver(BuildContext context)
{
  return SliverToBoxAdapter(
    child: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
            height: 200,
            child: Swiper(
                itemCount: 5,
                loop: true,
                outer: true,
                autoplay:true,
                autoplayDelay:5000,
                itemBuilder: (BuildContext context,int index)
                {
                  return Padding(padding: EdgeInsets.all(20),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[300]
                        ),
                        child: Text(""),
                       )
                  );
                }
            ),
      ),
    ),
  );
}

Widget EventViewList(BuildContext context)
{
  return ListView.builder(
      itemCount: 20,
      //itemExtent: 100,
      itemBuilder: (BuildContext context,int index){
        return Container(
          //width: 70,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //--------------------------------------
                  // 发帖人信息
                  Padding(padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[350]

                      ),
                    ),
                  ),

                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "用户$index",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "20232420${index%9}",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 17,
                            ),
                          ),
                        ]),
                  ),

                ],
              ),
              //-----------------------------------------------------------
              //--------------活动内容---------------------------------------
              Padding(padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-------------标题-------------
                    Text(
                      "标题$index",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    //----------------内容---------------------------
                    Text(
                      "内容${index}XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",
                      style: TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              //-----------------------------------------------------------------------
              //--------------------功能键----------------------------------------------
              Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  //评论
                  IconButton(onPressed: (){},
                    icon: Icon(Icons.chat_outlined),
                  ),
                  //点赞
                  IconButton(onPressed: (){}, icon: Icon(Icons.thumb_up_off_alt_outlined)),
                  //收藏
                  IconButton(onPressed: (){}, icon: Icon(Icons.star_border)),
                ],
              ),
              )
              ]
          ),
        );
      }
  );
}

