import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'TextTitle.dart';

class MenuCard extends StatelessWidget{
  String text,IconPath;
  VoidCallback onPressed;
  MenuCard(this.text, this.IconPath,this.onPressed);


  @override
  Widget build(BuildContext context) {
   return  GestureDetector(
       onTap:onPressed,
    child:Container(
     width: double.infinity,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
         TextTitle(
             text, Theme.of(context).textTheme.subtitle2),
         Container(
           margin: EdgeInsets.symmetric(horizontal: 50.0.sp,vertical: 30.0.sp),
           width: 111.sp,
           height: 111.sp,
           child: SvgPicture.asset(
             IconPath,
             color: Theme.of(context).primaryColor,
           ),
         ),

       ],
     ),
   ));
  }

}