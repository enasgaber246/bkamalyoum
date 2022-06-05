import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'TextTitle.dart';
class TextWithDot extends StatelessWidget{
  String text;
  double fontSize;
  TextStyle style;

  TextWithDot(this.text,this.style,{this.fontSize});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  Row(
     mainAxisAlignment: MainAxisAlignment.end,
     children: [
       Container(
         // padding: EdgeInsets.symmetric(vertical: 24.sp),
         alignment: Alignment.centerRight,
         child: TextTitle(
             text,style,fontSize: fontSize,),
       ),
       Container(
           margin: EdgeInsets.symmetric(horizontal: 30.0.sp),
           width: 20.0.sp,
           height: 20.0.sp,
           alignment: Alignment.centerRight,
           decoration: BoxDecoration(
               color: Theme.of(context).primaryColor,
               shape: BoxShape.circle)),
     ],
   );
  }

}