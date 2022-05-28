import 'package:bkamalyoum/Component/AuthInputData.dart';
import 'package:bkamalyoum/Component/Btn.dart';
import 'package:bkamalyoum/Component/TextTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _signupScreenState();
  }
}

class _signupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 60.0.sp,vertical: 60.0.sp),
            child: TextTitle(
              'يرجي تعبئة المعلومات التالية',
              Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.end,
            )),
        AuthInputData('الاسم'),
        AuthInputData('رقم الهاتف'),
        AuthInputData("كلمه المرور"),
        Spacer(),
        Btn('تسجيل',height: 178.0,fontSize: 62,fontWeight: FontWeight.w500,horizontal: 50.0,verticalMargin: 200,)

      ],
    );
  }
}
