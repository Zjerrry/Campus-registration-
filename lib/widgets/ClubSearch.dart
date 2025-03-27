import 'package:flutter/material.dart';
import 'Tool.dart';

//导入的社团列表
List allClub = ["天外天工作室","青年志愿者协会XXXXXXXXXXXXXXXXXXX","学生会","天津大学校园建设发展协会（北洋讲解队）","abcdef","abc"];//全部社团列表
List searchClub = [];//筛选后的社团列表


//顶部搜索栏
class TopSearchBar extends StatefulWidget {
  const TopSearchBar({super.key,required this.lable,required this.onSearch,required this.SearchValue});

  final String lable;
  final Function(String) onSearch;
  final String SearchValue;
  @override
  State<TopSearchBar> createState() => _TopSearchBarState();
}

class _TopSearchBarState extends State<TopSearchBar> {
  //FocusNode _focusNode = FocusNode();//焦点
  String SearchValue = "";
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      //_focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    //屏幕尺寸
    MediaQueryData queryData = MediaQuery.of(context);
    return Container(
      width: queryData.size.width*0.8,
      height: 40,
      padding: EdgeInsets.only(left: 20,right: 20),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white
      ),
      child:Padding(
        padding: EdgeInsets.all(5),
        child:TextField(
          controller: _controller,
          //focusNode: _focusNode,
          autofocus: false,
          decoration: InputDecoration(
            hintText: widget.lable,
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,

            icon: const Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(Icons.search,
                size: 20,
                color: Colors.black45,
              ),),
            //输入后显示的清除输入内容按键
            /*
            suffixIcon: SearchValue.isNotEmpty ?
            IconButton(onPressed: ()
            {
              setState(() {
                SearchValue = "";
                _controller.clear();
                //Search(_ClublistpageState.SearchValue);
              });
            }, icon: Icon(Icons.close)):null,*/

          ),
          onChanged: (value){
            setState(() {
              SearchValue = value;
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
//搜索筛选的实现
void Search(String SearchValue)
{
  searchClub = [];//初始化筛选列表
  if(SearchValue == "") {
    return;
  }
  for(int i=0;i<allClub.length;i++)
  {
    if(allClub[i].length<SearchValue.length)
      continue;
    if(StrStr(allClub[i], SearchValue) >= 0)
    {
      searchClub.add(allClub[i]);
    }
  }
}


