import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_fist/widgets/my_icons_icons.dart';
import 'package:test_fist/widgets/my_icons_icons.dart';

class EventSearch extends StatefulWidget {
  const EventSearch({super.key});

  @override
  State<EventSearch> createState() => _EventSearchState();
}

class _EventSearchState extends State<EventSearch> {
  TextEditingController _controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 352.w,
          height: 31.h,
          //padding: EdgeInsets.only(left: 20.r,right: 20.r),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.r),
              color: Colors.white
          ),
          child:Padding(
            padding: EdgeInsets.all(5.r),
            child:TextField(
              controller: _controller,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "搜索活动",
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
                  //SearchValue = value;
                });
              },
              onSubmitted: (value){
                //widget.onSearch(value);
              },
            ),
          ),

        ),
        actions: [
          Container(
            width: 40.w,
            height: 31.h,
            child: ElevatedButton(
                onPressed: () => setState(() {
                  _controller.text = "";
                }),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white
              ),
                  child: const Icon(Icons.close),
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 10.w))
        ],
      ),
    );
  }
}
