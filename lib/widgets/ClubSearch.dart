import 'package:flutter/material.dart';
import 'Tool.dart';
import 'package:test_fist/commons/Global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//导入的社团列表
List allClub = [];//全部社团列表
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
      allClub = GlobalInformation.AllClub;
    });
  }

  @override
  Widget build(BuildContext context) {
    //屏幕尺寸
    return Container(
      width: 352.w,
      height: 31.h,
      padding: EdgeInsets.only(left: 20.r,right: 20.r),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.r),
          color: Colors.white
      ),
      child:Padding(
        padding: EdgeInsets.all(5.r),
        child:TextField(
          controller: _controller,
          //focusNode: _focusNode,
          autofocus: false,
          decoration: InputDecoration(
            hintText: widget.lable,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,

            icon:  Padding(
              padding:  EdgeInsets.only(left: 20.w),
              child: const Icon(Icons.search,
                size: 25,
                color: Colors.black45,
              ),),

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


