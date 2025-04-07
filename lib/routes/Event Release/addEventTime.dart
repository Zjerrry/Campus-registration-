import 'package:flutter/material.dart';
import 'package:test_fist/commons/Global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
//用了date_picker_plus
class addEventTime extends StatefulWidget {
  const addEventTime({super.key});

  @override
  State<addEventTime> createState() => _addEventTimeState();
}

class _addEventTimeState extends State<addEventTime> {

  @override
  Widget build(BuildContext context) {
    return
       Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 400.h,
                    child: DatePicker(
                      centerLeadingDate: true,
                      minDate: DateTime(2025,4,1),
                      maxDate: DateTime(2028),
                      initialDate: DateTime(2025,4),
                      disabledCellsDecoration: const BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        );
  }
}
