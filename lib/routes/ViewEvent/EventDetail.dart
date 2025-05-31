import 'dart:convert';
import 'package:test_fist/routes/ViewClub/ClubMainPage.dart';
import 'package:flutter/material.dart';
import 'package:test_fist/routes/ViewClub/ClubListPage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({super.key, required this.event});

  final Map<String,dynamic> event;


  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  int _selectedSortIndex = 1; // 1=时间正序, 0=时间倒序
  List<Map<String,dynamic>> timeTap = [
    {
      'sort':'进行中',
      'color':Colors.purple
    },
    {
      'sort':'准备中',
      'color':Colors.blue
    },
    {
      'sort':'已结束',
      'color':Colors.grey
    },
  ];

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final publishTime = DateTime.parse(jsonDecode(event['publish_time']));
    final startTime = DateTime.parse(jsonDecode(event['start_time']));
    final endTime = DateTime.parse(jsonDecode(event['end_time']));
    int checkEventsRunning()
    {
      DateTime now = DateTime.now();
      if(now.isBefore(startTime))
        {
          return 1;
        }
      else if(endTime.isBefore(now))
        {
          return 2;
        }
      else{
        return 0;
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 发布者信息行
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey
                    ),
                  ),
                  Container(width: 12.w),
                  Expanded(
                    child: SizedBox(
                      height: 40.h, // 与头像同高
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children:
                            [
                              Text(event['publisher_name'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp,),),
                              SizedBox(width: 8.w),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(14.w),
                                ),
                                child: Text('天外天工作室', style: TextStyle(color: Colors.white, fontSize: 13.sp,),),
                              ),
                            ],
                          ),
                          Align( // 时间底部对齐
                            alignment: Alignment.bottomLeft,
                            child: Text('${publishTime.year}-${publishTime.month}-${publishTime.day}   ${publishTime.hour}:${publishTime.minute}',
                                style: Theme.of(context).textTheme.bodySmall
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 右侧标签
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(14.w),
                            ),
                            child: Text(event['school'] == 0 ?'双校区':event['school'] == 1 ?'卫津路':'北洋园', style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w500,),),
                          ),
                          SizedBox(height: 6.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: timeTap[checkEventsRunning()]['color'],
                              borderRadius: BorderRadius.circular(14.w),
                            ),
                            child: Text(timeTap[checkEventsRunning()]['sort'], style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w500,),),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                        child: Text('#HD0000${event['id']}', style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ],
                  ),],),
              SizedBox(height: 12.h),
              // 活动标题
              Text(event['title'],
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),

              // 活动详情
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 活动时间行
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 20.sp), // 时钟图标
                      SizedBox(width: 6.w),
                      Text("活动时间: ${startTime.year}-${startTime.month}-${startTime.day} -- ${endTime.year}-${endTime.month}-${endTime.day}", style: TextStyle(fontSize: 12.sp)),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  // 活动地点行
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 20.sp), // 位置图标
                      SizedBox(width: 6.w),
                      Text("活动地点: ${event['place']}", style: TextStyle(fontSize: 12.sp)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                event['content'],
                style: TextStyle(fontSize: 16.sp),
              ),
              const SizedBox(height: 12),

              // 关联社团
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 5.h),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: jsonDecode(event['link_club']).length,
                  itemBuilder: (context, index) {
                    final tagList = jsonDecode(event['link_club']);
                    return _buildClubTag(context, index, tagList);
                  },
                ),
              ),
              SizedBox(height: 15.h),

              // 浏览与排序控制
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '71次浏览',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  // 时间正序选项
                  GestureDetector(
                    onTap: () =>_selectedSortIndex=1, // 设置为正序
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text(
                        '时间正序',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: _selectedSortIndex== 1
                              ? Theme.of(context).primaryColor // 选中时蓝色
                              : Colors.black, // 未选中黑色
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12), // 选项间距

                  // 时间倒序选项
                  GestureDetector(
                    onTap: () =>_selectedSortIndex=0, // 设置为倒序
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Text(
                        '时间倒序',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color:_selectedSortIndex == 0
                              ? Theme.of(context).primaryColor
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(), // 将只看楼主推到右侧

                  // 只看楼主按钮
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // 灰色背景
                        borderRadius: BorderRadius.circular(16), // 圆角
                      ),
                      child: Text(
                        '只看楼主',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700], // 灰色文字
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // 评论列表
              _buildCommentSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // // 状态标签组件
  // Widget _buildStatusTag(String text, Color color) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //     decoration: BoxDecoration(
  //       color: color.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(4),
  //       border: Border.all(color: color),
  //     ),
  //     child: Text(
  //       text,
  //       style: TextStyle(color: color, fontSize: 12),
  //     ),
  //   );
  // }

  // // 活动信息行
  // Widget _buildEventInfo(String label, String value) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4),
  //     child: RichText(
  //       text: TextSpan(
  //         style: const TextStyle(color: Colors.black, height: 1.5),
  //         children: [
  //           TextSpan(text: label, style: const TextStyle(fontWeight: FontWeight.bold)),
  //           TextSpan(text: value),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // 话题标签组件
  // Widget _Clubtag(String tag) {
  //   return InkWell(
  //     onTap: () {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) {return ClubListPage();}
  //           )
  //       );
  //     },
  //     splashColor: Colors.blue.withOpacity(0.3),
  //     highlightColor: Colors.blue.withOpacity(0.1),
  //     borderRadius: BorderRadius.circular(4),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //       child: Text(
  //         tag,
  //         style: TextStyle(
  //           color: Colors.blueAccent,
  //           fontSize: 14.sp,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  /*应改为
  Widget _buildClubTag(BuildContext context,int index)
  {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          //side: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
        ),
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> ClubMainPage(
              club: GlobalInformation().linkingClubs[index],
            ))
        );
      },
      child: Text(
        "#${GlobalInformation().linkingClubs[index]['club_name']}",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:  TextStyle(
            color: Colors.blueAccent,
            fontSize: 14.sp
        ),
      ),
    );
  }*/
  // 评论区域组件
  Widget _buildCommentSection() {
    final comments = [
      {'user': '这是用户名', 'content': '这是内容\n这是内容这是内容\n这是内容这是内容这是内容这是内容', 'time': '25/03/17 00:00:00'},
      {'user': '这是用户名', 'content': '这是内容\n这是内容\n这是内容这是内容', 'time': '25/03/18 00:00:00'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 评论头部
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, // 顶部对齐
                children: [
                  // 左侧头像列
                  Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 8.w), // 头像与内容间距

                  // 右侧用户名和内容列
                  Expanded( // 占据剩余空间[4](@ref)
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, // 左对齐[2](@ref)
                      mainAxisSize: MainAxisSize.min, // 高度包裹内容[6](@ref)
                      children: [
                        // 用户名
                        Text(comment['user']!),
                        const SizedBox(height: 8), // 用户名与内容间距

                        // 评论内容
                        Text(comment['content']!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(icon: const Icon(Icons.thumb_up_alt_outlined, size: 18), onPressed: () {}),
                                IconButton(icon: const Icon(Icons.thumb_down_alt_outlined, size: 18), onPressed: () {}),
                              ],
                            ),
                            Text(comment['time']!, style: Theme.of(context).textTheme.bodySmall),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // 底部互动栏
  Widget _buildBottomBar() {
    return BottomAppBar(
      height: 50.h,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '友善回复，真诚沟通',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.thumb_up_alt_outlined, size: 24), onPressed: () {}),
          IconButton(icon: const Icon(Icons.star_border_outlined,size:27), onPressed: () {}),
          IconButton(icon: const Icon(Icons.thumb_down_alt_outlined, size: 24), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildClubTag(BuildContext context,int index,List link_clubs)
  {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> ClubMainPage(
              club: link_clubs[index],
            ))
        );
      },
      child: Text(
        "#${link_clubs[index]['club_name']}",
        //maxLines: 1,
        //overflow: TextOverflow.ellipsis,
        style:  TextStyle(
            color: Colors.blueAccent,
            fontSize: 14.sp
        ),
      ),
    );
  }
}