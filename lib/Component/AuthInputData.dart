import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'TextTitle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'InputData.dart';

class AuthInputData extends StatelessWidget {
  String text;

  AuthInputData(this.text);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 60.0.sp,vertical: 60.0.sp),
            child: TextTitle(
              text,
              Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.end,
            )),
        InputData(
          height: 178.0,
          horizontal: 50.0,
        ),
      ],
    );
  }
}
