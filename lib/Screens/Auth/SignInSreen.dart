import 'package:bkamalyoum/Component/AuthInputData.dart';
import 'package:bkamalyoum/Component/Btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _signinScreenState();
  }

}
class _signinScreenState extends State<SigninScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        AuthInputData('اسم المستخدم'),
        AuthInputData("كلمه المرور"),
        Spacer(),
        Btn('دخول',height: 178.0,fontSize: 62,fontWeight: FontWeight.w500,horizontal: 50.0,verticalMargin: 400,)
      ],
    );
  }

}