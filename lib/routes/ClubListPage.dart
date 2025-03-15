import 'package:flutter/material.dart';
import 'ClubMainPage.dart';

List allClub = ["天外天工作室","青年志愿者协会","学生会","天津大学校园建设发展协会（北洋讲解队）","abcdef","abc"];//全部社团列表
List searchClub = [];//筛选后的社团列表

class Clublistpage extends StatefulWidget {
  const Clublistpage({super.key});

  @override
  State<Clublistpage> createState() => _ClublistpageState();
}

class _ClublistpageState extends State<Clublistpage> {
  static String SearchValue = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TopSearchBar(
            lable: "搜索社团",
            onSearch: (value){
              setState(() {
                SearchValue = value;
                Search(SearchValue);
              });
            },
        ),
      ),
      body: ClubList_Body()
    );
  }
}

//顶部搜索栏
class TopSearchBar extends StatefulWidget {
  const TopSearchBar({super.key,required this.lable,required this.onSearch});

  final String lable;
  final Function(String) onSearch;

  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  FocusNode _focusNode = FocusNode();//焦点
  //String SearchValue = "";
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    //屏幕尺寸
    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
      width: queryData.size.width ,
      height: 40,
      padding: EdgeInsets.only(left: 20,right: 20),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      child:Padding(
          padding: EdgeInsets.all(5),
          child:TextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: false,
        decoration: InputDecoration(
            hintText: widget.lable,
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            icon: const Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(Icons.search,
                size: 18,
                color: Colors.blue,
              ),),
            //输入后显示的清除输入内容按键
            suffixIcon: _ClublistpageState.SearchValue.isNotEmpty ?
            IconButton(onPressed: ()
            {
              setState(() {
                _ClublistpageState.SearchValue = "";
                _controller.clear();
                //Search(_ClublistpageState.SearchValue);
              });
            }, icon: Icon(Icons.close)):null
            ),
        onChanged: (value){
          setState(() {
            _ClublistpageState.SearchValue = value;
          });
        },
        onSubmitted: (value){
          widget.onSearch(value);
        },
      ),
      ),

    );
  }
}

//社团列表
class ClubList_Body extends StatefulWidget {
  const ClubList_Body({super.key});

  @override
  State<ClubList_Body> createState() => _ClubList_BodyState();
}

class _ClubList_BodyState extends State<ClubList_Body> {
  List dataList = _ClublistpageState.SearchValue != "" ? searchClub:allClub;
  @override
  Widget build(BuildContext context) {//改为瀑布流式布局，待解决
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7
        ),
        itemCount: _ClublistpageState.SearchValue.isNotEmpty ? searchClub.length:allClub.length,
        itemBuilder: (context,index){
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)
                          {
                            return ClubMainPage(
                              clubname:_ClublistpageState.SearchValue.isNotEmpty ? searchClub[index]:allClub[index] ,
                            );
                          })
                  );
                },//点击后打开社团介绍页
                child: Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      //color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Image.network("https://tse2-mm.cn.bing.net/th/id/OIP-C.OTqjOW2I-11mg43Ki0q5wwHaHa?w=186&h=186&c=7&r=0&o=5&dpr=2.1&pid=1.7"),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text("${_ClublistpageState.SearchValue.isNotEmpty ? searchClub[index]:allClub[index]}",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                        )
                      ],
                    )
                ),
              )
          );
        }
    );
  }
}

void Search(String SearchValue)//搜索筛选的实现
{
  searchClub = [];//初始化筛选列表
  if(SearchValue == "") {
    return;
  }
  for(int i=0;i<allClub.length;i++)
    {
      if(allClub[i].length<SearchValue.length)
        continue;
      if(allClub[i].substring(0,SearchValue.length) == SearchValue)
        {
          searchClub.add(allClub[i]);
        }
    }
}

