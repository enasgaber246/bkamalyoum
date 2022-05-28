import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputDataWidget extends StatelessWidget {
  TextEditingController controller;
  @override
  Widget build(BuildContext mcontext) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 15.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      height: 104.67.sp,
        width: 1021.07.sp,
        decoration: BoxDecoration(
            border: Border.all(
              color:Theme.of(mcontext).primaryColor,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
       child:  TextField(
         controller: controller,
         decoration: InputDecoration(
           border: InputBorder.none,
         ),

       ),
    );
  }
}
