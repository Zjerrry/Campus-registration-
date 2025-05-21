import 'package:flutter/material.dart';
import 'package:test_fist/routes/Settings/ClubSettings.dart';
import 'package:test_fist/commons/Global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_fist/widgets/my_icons_icons.dart';

class ClubMainPage extends StatefulWidget {
  const ClubMainPage({super.key,required this.club});
  final Map<String,dynamic> club;

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
                child: Padding(
                  padding:  EdgeInsets.all(8.0.r),
                  child: Text("社团主页",style: TextStyle(fontSize: 20.38.sp,fontWeight: FontWeight.w700),),
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
              icon: Icon(MyIcons.setting_2,size: 30.sp,)
          )
        ],
      ),

      body: CustomScrollView(
        slivers: [
          //------------------------------------------------------------------------
          //社团信息
          ClubInformation(club: widget.club,),

          //-------------------------社团活动----------------------------------------
          SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context,index)
              {
                return Padding(
                  padding:  EdgeInsets.all(8.0.r),
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
  const ClubInformation({super.key,required this.club});
  final Map<String,dynamic> club;

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
              padding: EdgeInsets.all(20.0.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      child: ClipRRect(
                        //borderRadius:  const BorderRadius.vertical(top: Radius.circular(20)),
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
                    ),
                  ),
                  //社团头像
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //--------------名称------------------------
                        Text(widget.club['club_name'],
                          style:TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.sp
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Container(
                            height: 1,
                            width: 158.w,
                            color: const Color(0xFFD9D9D9),
                          ),
                        ),
                        //--------------类型---------------------
                        Padding(padding: EdgeInsets.only(right: 40.w),
                          child: Container(
                            height: 25.h,
                            width: 94.w,
                            decoration: BoxDecoration(
                                color: Colors.orange[400],
                                borderRadius: BorderRadius.circular(31.r)
                            ),
                            child:Center(
                              child: Text(widget.club['club_sort'],style: TextStyle(
                                  fontWeight: FontWeight.w700,fontSize: 13.sp
                              ),),
                            ),
                          ),
                        ),
                        //社团类型
                      ],//会溢出屏幕
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 55.h),
                    child: Row(
                      children: [
                        Container(
                            width: 58.w,
                            height: 25.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: Colors.grey
                            ),
                            child: Center(
                              child: Text(GlobalInformation().collectedClubs.contains(widget.club)
                                  ?"已关注":"关注社团"
                                ,style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp
                              ),),
                            )
                        ),
                        IconButton(icon:Icon(GlobalInformation().collectedClubs.contains(widget.club)
                            ?Icons.star:Icons.star_border,size: 23,
                          color:GlobalInformation().collectedClubs.contains(widget.club)
                              ?Colors.yellow[700]:Colors.black,),
                            onPressed: (){
                              if(!GlobalInformation().collectedClubs.contains(widget.club)) {
                                GlobalInformation().addCollectedClub(widget.club);
                              }
                              else{
                                GlobalInformation().removeCollectedClub(widget.club);
                              }
                              setState(() {});
                            }
                        ) //是否关注该社团
                      ],
                    ),
                  )
                ],),
            ),
            //-------------------------------------------------------------
            //社团简介部分
            //---------------------------------------------------------------
            ConstrainedBox(
              constraints:BoxConstraints(
                  minHeight: 100.h
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: EdgeInsets.only(right: 20.r,top: 3.r),
                      child: Text("社团简介:",style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          fontSize: 16.sp
                      )
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.club['club_information'],
                        style: TextStyle(
                            color: Colors.grey[600],
                            height: 1.5.h,
                            fontSize: 14.sp
                        ),
                      ),
                    )

                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10.r),
              child: Container(
                height: 1.h,
                color: const Color(0xFFD9D9D9),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0.r,bottom: 10.0.r),
              child: Text("活动一览",style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25.sp,
                  color: Colors.grey
              ),),
            )
          ],
        ),
      ),
    );
  }
}

