import 'package:flutter/material.dart';
import 'package:test_fist/widgets/ClubSearch.dart';
import 'package:test_fist/widgets/Tool.dart';
import 'package:test_fist/commons/Global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
        padding: EdgeInsets.symmetric(horizontal: 120.w),
        child: ElevatedButton(
          onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
            setState(() {

            });
          },
          child: Text("完成添加社团",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6CB2F3),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 45.h),
                child: Text("添加关联社团",
                  style: TextStyle(color: Colors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold
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
            padding:  EdgeInsets.all(30.0.w),
            sliver: SliverGrid(

              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 22.0.h,
                crossAxisSpacing: 10.0.h,
                childAspectRatio: 4,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {

                  return Container(
                    alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                          boxShadow: [BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2.h,
                              blurRadius: 5.h
                          ),]
                      ),
                    //-----------------------------------------------------
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius:  const BorderRadius.only(
                              topLeft:Radius.circular(30),bottomLeft: Radius.circular(30)),
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
                        //--------------------文字---------------------------
                        Expanded(
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //截取固定长度的文字
                                  truncateText(SearchValue.isNotEmpty ? searchClub[index] : allClub[index], 10),
                                  style:  TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      height: 1.5.h
                                  ),
                                  //maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                 SizedBox(height: 6.h),
                                Container(
                                  width: 94.w,
                                  height: 17.h,

                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1CF8B),
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child:Center(
                                    child: Text(
                                      "育人实践基地",
                                      //style: _kLabelStyle,
                                      strutStyle: StrutStyle(height: 1.h),
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //-------------------------------添加关联社团-------------------------------
                        Padding(padding:  EdgeInsets.all(20.w),
                        child: ElevatedButton(
                            onPressed: (){
                              setState(() {
                                if(!GlobalInformation().linkingClubs.contains(SearchValue.isNotEmpty ?
                                    searchClub[index]:allClub[index]))
                                  {
                                    GlobalInformation().addLinkingClub(SearchValue.isNotEmpty ?
                                    searchClub[index]:allClub[index]);
                                  }
                                else
                                  {
                                    GlobalInformation().removeLinkingClub(SearchValue.isNotEmpty ?
                                    searchClub[index]:allClub[index]);

                                  }
                              });
                            },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalInformation().linkingClubs.contains(SearchValue.isNotEmpty ?
                            searchClub[index] :
                            allClub[index]) ?
                            const  Color(0xFF6CB2F3) :
                            Colors.white60
                          ),
                          child: Text(GlobalInformation().linkingClubs.contains(SearchValue.isNotEmpty ?
                          searchClub[index] :
                          allClub[index]) ?
                            "已添加" :
                            "待添加",
                            style: const TextStyle(
                                color: Colors.black
                            ),),
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
