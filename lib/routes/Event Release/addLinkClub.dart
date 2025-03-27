import 'package:flutter/material.dart';
import 'package:test_fist/widgets/ClubSearch.dart';
import 'package:test_fist/widgets/Tool.dart';
Set<String> Club_added={};
List<bool> has_add=[];
class addLinkClub extends StatefulWidget {
  const addLinkClub({super.key});

  @override
  State<addLinkClub> createState() => _addLinkClubState();
}

class _addLinkClubState extends State<addLinkClub> {
  String SearchValue = "";

  @override
  Widget build(BuildContext context) {
    for(var i = 0;i<(SearchValue.isNotEmpty ? searchClub.length:allClub.length);i++)
    {
      has_add.add(false);
    }
    return Scaffold(
      backgroundColor: Colors.grey[350],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100),
        child: ElevatedButton(
          onPressed: (){
            setState(() {
              print("Club:$Club_added");
              Navigator.pop(context,Club_added);
            });

          },
          child: Text("完成社团添加",
            style: TextStyle(
                color: Colors.black
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 50),
                child: Text("添加关联社团",
                  style: TextStyle(color: Colors.black,
                      fontSize: 30
                  ),
                ),
                ),
                TopSearchBar(
                    lable: "搜索社团",
                    onSearch: (value){
                      setState(() {
                        SearchValue = value;
                        Search(SearchValue);
                      });
                    },
                    SearchValue: SearchValue
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(40.0),
            sliver: SliverGrid(

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 40.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 4.0,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {

                  return Container(
                    alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5
                          ),]
                      ),

                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius:  const BorderRadius.only( topLeft:Radius.circular(40),bottomLeft: Radius.circular(40)),
                          child: AspectRatio(
                            aspectRatio: 1,//图片尺寸
                            child: Image.asset("assets/images/twt.png",
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container( // 错误处理
                                color: Colors.grey[200],
                                child: const Icon(Icons.broken_image),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //截取固定长度的文字
                                  truncateText(SearchValue.isNotEmpty ? searchClub[index] : allClub[index], 10),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2
                                  ),
                                  //maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.orangeAccent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    "育人实践基地",
                                    //style: _kLabelStyle,
                                    strutStyle: StrutStyle(height: 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //添加选项
                        Padding(padding: EdgeInsets.all(20),
                        child: ElevatedButton(
                            onPressed: (){
                              setState(() {
                                if(!Club_added.contains(SearchValue.isNotEmpty ? searchClub[index]:allClub[index]))
                                  {
                                    Club_added.add(SearchValue.isNotEmpty ? searchClub[index]:allClub[index]);
                                  }
                                else
                                  {
                                    Club_added.remove(SearchValue.isNotEmpty ? searchClub[index]:allClub[index]);
                                  }
                              });
                            },
                            child: Text(Club_added.contains(SearchValue.isNotEmpty ? searchClub[index]:allClub[index])?"已添加":"待添加",
                            style: TextStyle(
                              color: Colors.black
                            ),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Club_added.contains(SearchValue.isNotEmpty ? searchClub[index]:allClub[index])?Colors.blue[100]:Colors.white60
                          ),
                         ),
                        )

                      ],
                    ),
                  );
                },
                childCount: SearchValue.isNotEmpty ? searchClub.length:allClub.length,
              ),
            ),
          ),


        ],
      ),
    );
  }
}
